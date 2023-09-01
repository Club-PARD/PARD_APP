import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/model/point_model/point_model.dart';
import 'package:pard_app/model/user_model/user_model.dart';

class PointController extends GetxController {
  final UserController _userController = Get.put(UserController());
  RxMap userPointsMap = {}.obs; // UserModel, int
  Rx<PointModel?> rxPointModel = Rx<PointModel?>(null);
  RxInt points = 0.obs;
  RxInt beePoints = 0.obs;
  RxInt level = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAndSortUserPoints();
    fetchCurrentUserPoints();
  }

  // 모든 멤버의 포인트를 계산하고 내림차순으로 정렬
  Future<void> fetchAndSortUserPoints() async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await usersCollection.where('pid', isNotEqualTo: '').get();

    Map<UserModel, int> resultMap = {};

    await Future.forEach(querySnapshot.docs, (doc) async {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userData);

      int totalPoints = 0;

      String pid = userData['pid'];

      // Fetch points from 'points' collection using the user's pid
      DocumentSnapshot pointsSnapshot =
          await FirebaseFirestore.instance.collection('points').doc(pid).get();

      if (pointsSnapshot.exists) {
        Map<String, dynamic> pointsData =
            pointsSnapshot.data() as Map<String, dynamic>;

        if (pointsData.containsKey('points') &&
            pointsData['points'] is List<dynamic>) {
          List<dynamic> pointsList = pointsData['points'];
          for (var point in pointsList) {
            if (point is Map<String, dynamic> && point.containsKey('digit')) {
              totalPoints += point['digit'] as int;
            }
          }
        }

        if (pointsData.containsKey('beePoints') &&
            pointsData['beePoints'] is List<dynamic>) {
          List<dynamic> beePointsList = pointsData['beePoints'];
          for (var beePoint in beePointsList) {
            if (beePoint is Map<String, dynamic> &&
                beePoint.containsKey('digit')) {
              totalPoints -= beePoint['digit'] as int;
            }
          }
        }
      }

      print("Calculating points for user: ${user.name}");
      print("Total points: $totalPoints");
      resultMap[user] = totalPoints;
    });

    // 정렬 후, resultMap을 userPointsMap으로 업데이트
    resultMap = Map.fromEntries(resultMap.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    // RxMap을 업데이트
    userPointsMap.assignAll(resultMap);
  }

  // 현재 유저의 등수를 반환하는 함수
  int getCurrentUserRank() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final Map<UserModel, int> userPointsMapCopy = Map.from(userPointsMap);
      List<UserModel> sortedUsers = userPointsMapCopy.keys.toList();
      sortedUsers.sort(
          (a, b) => userPointsMapCopy[b]!.compareTo(userPointsMapCopy[a]!));

      int currentUserIndex =
          sortedUsers.indexWhere((user) => user.email == currentUser.email);
      if (currentUserIndex != -1) {
        return currentUserIndex + 1;
      } else {
        return -1;
      }
    } else {
      return -2;
    }
  }

  // 현재 유저의 파트 내 등수를 반환하는 함수
  int getCurrentUserPartRank() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      _userController.getUserInfoByEmail(currentUser.email!);
      UserModel? currentUserModel = _userController.userInfo.value;

      final Map<UserModel, int> userPointsMapCopy = Map.from(userPointsMap);
      List<UserModel> sortedUsers = userPointsMapCopy.keys.toList();
      sortedUsers.sort(
          (a, b) => userPointsMapCopy[b]!.compareTo(userPointsMapCopy[a]!));

      int currentUserIndex =
          sortedUsers.indexWhere((user) => user.part == currentUserModel!.part);

      if (currentUserIndex != -1) {
        return currentUserIndex + 1;
      } else {
        return -1; // 파트 내에서 해당 유저를 찾지 못한 경우
      }
    } else {
      return -2; // 로그인된 유저가 없는 경우
    }
  }

  // 현재 유저의 포인트 & 벌점를 가져오는 함수
  Future<void> fetchCurrentUserPoints() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // users 컬렉션에서 해당 이메일에 해당하는 문서를 찾기
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: currentUser.email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        String pid = userSnapshot.docs[0]['pid'];

        // points 컬렉션에서 해당 pid에 해당하는 문서 가져오기
        DocumentSnapshot pointsSnapshot = await FirebaseFirestore.instance
            .collection('points')
            .doc(pid)
            .get();

        if (pointsSnapshot.exists) {
          PointModel pointModel = PointModel.fromJson(
              pointsSnapshot.data() as Map<String, dynamic>);

          int totalPoints = 0;
          int totalBeePoints = 0;

          if (pointModel.points != null) {
            for (var point in pointModel.points!) {
              totalPoints += (point['digit'] ?? 0) as int;
            }
          }

          if (pointModel.beePoints != null) {
            for (var beePoint in pointModel.beePoints!) {
              totalBeePoints += (beePoint['digit'] ?? 0) as int;
            }
          }

          rxPointModel.value = pointModel;
          points.value = totalPoints;
          beePoints.value = totalBeePoints;

          // 레벨 계산
          int calculatedPoints = totalPoints - totalBeePoints;
          if (calculatedPoints >= 0 && calculatedPoints <= 25) {
            level.value = 1;
          } else if (calculatedPoints <= 50) {
            level.value = 2;
          } else if (calculatedPoints <= 75) {
            level.value = 3;
          } else if (calculatedPoints <= 100) {
            level.value = 4;
          } else {
            level.value = 5;
          }
        }
      }
    }
  }

  //QR 찍었을 때 점수 추가 
Future<void> attendQR(UserModel user, int attendPoint) async {
  
  String? pid = user.pid;
  DocumentReference pointsRef = FirebaseFirestore.instance.collection('points').doc(pid); //user의 pid

  // 포인트 정보를 가져옵니다.
  DocumentSnapshot pointsSnapshot = await pointsRef.get();
    //현재 포인트 구하기
    Map<String, dynamic> existingPoints = pointsSnapshot.data() as Map<String, dynamic>;
    print("existingPoints type: ${existingPoints.runtimeType}");

    // 기존 포인트 목록에 출석 포인트 추가
    List<Map>? currentPoints = existingPoints['points'];
    currentPoints?.add({'digit': attendPoint});

    // 데이터베이스 업데이트
    await pointsRef.update({'points': currentPoints});
  

  // 로컬 상태 업데이트 (선택 사항)
  fetchAndSortUserPoints();
  fetchCurrentUserPoints();
}

}
