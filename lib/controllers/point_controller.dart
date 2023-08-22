import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pard_app/model/point_model/point_model.dart';

class PointController extends GetxController {
  String uid = '2PGKaxqRrZhA0dt6o3DV';
  String pid = '';

  Future<void> getUserUid() async {
    // 현재 인증된 사용자 가져오기
    // User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    // Firestore에서 사용자 문서 가져오기
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    // 사용자 문서에서 UID 가져와 로컬 변수에 저장
    uid = userSnapshot['uid'];

    print("user id: $uid");
    // }
  }

  Future<void> getUserPoints() async {
    // 현재 인증된 사용자 가져오기
    // User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    // Firestore에서 points 컬렉션에서 사용자 UID와 동일한 필드값을 가진 문서 찾기
    QuerySnapshot pointsSnapshot = await FirebaseFirestore.instance
        .collection('points')
        .where('uid', isEqualTo: uid)
        .get();

    // 만약 문서가 하나 이상 있다면 첫 번째 문서의 값을 로컬 변수에 저장
    if (pointsSnapshot.docs.isNotEmpty) {
      pid = pointsSnapshot.docs[0]['pid'];
      print("point id: $pid");
    }
    // }
  }

  Future<void> getUserDataAndPoints() async {
    // 현재 인증된 사용자 가져오기
    // User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    // uid = user.uid;

    // Firestore에서 points 컬렉션에서 사용자의 pid와 일치하는 문서 가져오기
    DocumentSnapshot pointsSnapshot = await FirebaseFirestore.instance
        .collection('points')
        .doc(pid) // pid를 사용하여 문서 검색
        .get();

    if (pointsSnapshot.exists) {
      PointModel pointModel =
          PointModel.fromJson(pointsSnapshot.data() as Map<String, dynamic>);

      // beePoints의 digit 값들의 합 구하기
      int sum = 0;
      if (pointModel.beePoints != null) {
        for (var beePoint in pointModel.beePoints!) {
          sum += (beePoint['digit'] ?? 0) as int;
        }
      }

      print(pointModel.pid!);
      print(pointModel.points);
      print(pointModel.beePoints);
      print("beePoints Sum: $sum");
    }
    // }
  }
}
