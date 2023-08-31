
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pard_app/model/user_model/user_model.dart';

class UserController extends GetxController {
  final CollectionReference<Map<String, dynamic>> usersCollection =
      FirebaseFirestore.instance.collection('users');
  Rx<UserModel?> userInfo = Rx<UserModel?>(null);
  Rx<String?> deviceName = Rx<String?>(null); 
  Rx<String?> deviceVersion = Rx<String?>(null);
  Rx<String?> fcmToken = Rx<String?>(null);
  late final FirebaseMessaging firebaseMessaging =FirebaseMessaging.instance;
  
  //user모델 가져오기(by 이메일)
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
        print('pid: ${user.email}');
        print('attend: ${user.attend}');
        print('fcmToken : ${user.fcmToken}');
        userInfo.value = user;
      } else {
        print('사용자 정보 없음');
      }
    } catch (error) {
      print("Error while fetching user info: $error");
    }
  }

  //유저의 Email이 저장되어 있는지 (휴대폰 인증이 필요한지) 체크
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

  //user모델 가져오기(by uid)
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
        print('pid: ${user.email}');
        print('attend: ${user.attend}');
        userInfo.value = user;
      } catch (e) {
        print('user정보 불러오기 실패');
      }
    } else {
      print('user 불러오기 실패');
      return;
    }
  }

  //이메일 저장(휴대폰 인증 성공시 사용 함수)
  Future<void> saveEmail(String uid, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'email': email,
    });
  }

  Future<void> saveFcmToken(String fcmToken) async {
    final fcmToken = await firebaseMessaging.getToken();
    print('저장용 토큰 ------------------------');
    print(fcmToken);
    await FirebaseFirestore.instance.collection('users').doc(fcmToken).update({
      'fcmToken': fcmToken,
    });
  }

Future<void> updateAttend(String? uid, String? qrCode) async {
  if (uid == null || qrCode == null) {
    print("uid null값");
    return;
  }
  final currentTime = DateTime.now().toIso8601String(); 
  final userDocument = FirebaseFirestore.instance.collection('users').doc(uid);

  try {
    await userDocument.update({
      'attend': {qrCode: currentTime}
    });
  } catch (e) {
    print(e);
  }
}



  //로그인 기록 업데이트(by 이메일) - 휴대폰 인증 성공시, 휴대폰 인증 완료 후 다시 로그인 할 때,
  Future<void> updateTimeByEmail(String email) async {
    final currentTime = Timestamp.now();

    final usersCollection = FirebaseFirestore.instance.collection('users');
    final querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      await userDoc.reference.update({
        'lastLogin': currentTime,
      });
    } else {
      print('사용자를 찾을 수 없습니다: $email');
    }
  }

  //휴대폰 인증 성공시
  Future<void> setUserByEmail(String email) async {
    final currentTime = Timestamp.now();

    final usersCollection = FirebaseFirestore.instance.collection('users');
    final querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      await userDoc.reference.update({
        'lastLogin': currentTime,
        'attend': <String, dynamic>{},
        
      }
      );
      print('유저세팅성공 $email');
    } else {
      print('사용자를 찾을 수 없습니다: $email');
    }
  } 

  Future<void> AddAttend(String sid, String attend) async {
    final userDocument = FirebaseFirestore.instance.collection('users').doc(userInfo.value!.uid);
    
    try {
      final userSnapshot = await userDocument.get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        
        userData['attend'] ??= <String, dynamic>{};
        userData['attend'][sid] = attend;
        await userDocument.update({'attend': userData['attend']});
      }
    } catch(e) {
      print(e);
    }
  } 


  //휴대폰 기종 파악
  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName.value = androidInfo.model; // Android 기기의 모델명
        deviceVersion.value = androidInfo.version.release; // Android 기기의 버전
      } else if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName.value = iosInfo.model; // iOS 기기의 모델명
        deviceVersion.value = iosInfo.systemVersion; // IOS 기기의 버전
      }
    } catch (e) {
      print("디바이스 모델명 불러오기 실패: $e");
    }
  }
}
