import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pard_app/model/user_model/user_model.dart';

class UserController extends GetxController {
  final CollectionReference<Map<String, dynamic>> usersCollection =
      FirebaseFirestore.instance.collection('users');
  Rx<UserModel?> userInfo = Rx<UserModel?>(null);

  //user 필드값 가져오기
  Future<void> getUserInfoByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs.first.data();

        UserModel user = UserModel.fromJson(userData);

        print('사용자 정보:');
        print('uid: ${user.uid}');
        print('name: ${user.name}');
        print('phoneNumber: ${user.phone}');
        print('email: ${user.email}');
        print('part: ${user.part}');
        print('member: ${user.member}');
        print('generation: ${user.generation}');
        print('isAdmin: ${user.isAdmin}');
        print('isMaster: ${user.isMaster}');
        print('lastLogin: ${user.lastLogin}');
        userInfo.value = user;
      } else {
        print('사용자 정보 없음');
      }
    } catch (error) {
      print("Error while fetching user info: $error");
    }
  }

  Future<bool> isVerifyUserByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print("Error while verifying user by email: $error");
      return false;
    }
  }

  Future<void> getUserInfoByUID(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await usersCollection.doc(uid).get();

    if (snapshot.exists) {
      try {

        UserModel user = UserModel.fromJson(snapshot.data()!);
        
        print('사용자 정보:');
        print('uid: ${user.uid}');
        print('name: ${user.name}');
        print('phoneNumber: ${user.phone}');
        print('email: ${user.email}');
        print('part: ${user.part}');
        print('member: ${user.member}');
        print('generation: ${user.generation}');
        print('isAdmin: ${user.isAdmin}');
        print('isMaster: ${user.isMaster}');
        print('lastLogin: ${user.lastLogin}');
        userInfo.value = user;
      } catch (e) {
        print('user정보 불러오기 실패');
      }
    } else {
      print('user 불러오기 실패');
      return;
    }
  }

  //가입(하면 이메일 저장)
  Future<void> saveEmail(String uid, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'email': email,
    });
  }

  Future<void> updateTimeByEmail(String email) async {
    final currentTime = Timestamp.now();

    final usersCollection = FirebaseFirestore.instance.collection('users');
    final querySnapshot = await usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
    final userDoc = querySnapshot.docs.first;
    await userDoc.reference.update({
      'lastLogin': currentTime,
    });
  } else {
    print('사용자를 찾을 수 없습니다: $email');
  }
  }
}
