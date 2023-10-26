import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/model/point_model/point_model.dart';
import 'package:pard_app/model/user_model/user_model.dart';

class PointController extends GetxController {
  final UserController _userController = Get.put(UserController());
  final AuthController _authController = Get.put(AuthController());
  RxMap userPointsMap = {}.obs; // UserModel, double
  Rx<PointModel?> rxPointModel = Rx<PointModel?>(null);
  RxInt currentUserRank = 0.obs;
  RxInt currentUserPartRank = 0.obs;

  /////////////////////////////////////////////////////////////
  // 모든 멤버의 포인트를 계산하고 내림차순으로 정렬
  Future<void> fetchAndSortUserPoints() async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersCollection
        .where('pid', isNotEqualTo: '')
        .where('member', whereIn: ['파디', '거친파도']).get();

    Map<UserModel, double> resultMap = {};

    await Future.forEach(querySnapshot.docs, (doc) async {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userData);

      double totalPoints = 0.0;
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
              if (point['digit'] is int) {
                totalPoints += (point['digit'] as int).toDouble();
              } else if (point['digit'] is double) {
                totalPoints += point['digit'] as double;
              }
            }
          }
        }

        // 벌점 빼기
        // if (pointsData.containsKey('beePoints') &&
        //     pointsData['beePoints'] is List<dynamic>) {
        //   List<dynamic> beePointsList = pointsData['beePoints'];
        //   for (var beePoint in beePointsList) {
        //     if (beePoint is Map<String, dynamic> &&
        //         beePoint.containsKey('digit')) {
        //       if (beePoint['digit'] is int) {
        //         totalPoints += (beePoint['digit'] as int).toDouble();
        //       } else if (beePoint['digit'] is double) {
        //         totalPoints += beePoint['digit'] as double;
        //       }
        //     }
        //   }
        // }
      }

      // print("Calculating points for user: ${user.name}");
      // print("Total points: $totalPoints");
      resultMap[user] = totalPoints;
    });

    // 정렬 후, resultMap을 userPointsMap으로 업데이트
    resultMap = Map.fromEntries(resultMap.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    // RxMap을 업데이트
    userPointsMap.assignAll(resultMap);
  }

  /////////////////////////////////////////////////////////////
  // 현재 유저의 등수를 반환하는 함수
  Future<void> getCurrentUserRank() async {
    final Map<UserModel, double> userPointsMapCopy = Map.from(userPointsMap);
    List<UserModel> sortedUsers = userPointsMapCopy.keys.toList();

    sortedUsers
        .sort((a, b) => userPointsMapCopy[b]!.compareTo(userPointsMapCopy[a]!));

    int currentUserIndex = sortedUsers.indexWhere(
        (user) => user.email == _userController.userInfo.value!.email);
    if (currentUserIndex != -1) {
      currentUserRank.value = currentUserIndex + 1;
    }
  }

  /////////////////////////////////////////////////////////////
  // 현재 유저의 파트 내 등수를 반환하는 함수
  getCurrentUserPartRank() async {
    final Map<UserModel, double> userPointsMapCopy = Map.from(userPointsMap);

    List<MapEntry<UserModel, double>> sortedEntries =
        userPointsMapCopy.entries.toList();

    sortedEntries.sort((entry1, entry2) {
      int pointsComparison = entry2.value.compareTo(entry1.value);

      if (pointsComparison == 0) {
        // 포인트가 같을 경우 이름을 기준으로 내림차순으로 정렬
        return entry2.key.name!.compareTo(entry1.key.name!);
      }

      return pointsComparison;
    });

    // 정렬된 결과를 다시 Map으로 변환
    final Map<UserModel, double> sortedUserPointsMap =
        Map.fromEntries(sortedEntries);

    // 정렬된 결과를 사용하여 출력 또는 다른 작업 수행
    int rank = 1;
    int currentUserIndex = 0;

    for (var entry in sortedUserPointsMap.entries) {
      if (entry.key.part == _userController.userInfo.value!.part) {
        print('Rank $rank: ${entry.key.name}, Points: ${entry.value}');
        if (entry.key.name == _userController.userInfo.value!.name) {
          currentUserIndex = rank;
        }
        rank++;
      }
    }

    currentUserPartRank.value = currentUserIndex;
  }

  /////////////////////////////////////////////////////////////
  // 현재 유저의 포인트 & 벌점를 가져오는 함수
  Future<void> fetchCurrentUserPoints() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    try {
      if (currentUser != null) {
        // users 컬렉션에서 해당 이메일에 해당하는 문서를 찾기
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: _userController.userInfo.value!.email)
            .get();

        print(
            'fetchCurrentUserPoints() 함수 실행: ${_userController.userInfo.value!.email}');

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

            double totalPoints = 0;
            double totalBeePoints = 0;

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

            pointModel.currentPoints = totalPoints;
            pointModel.currentBeePoints = totalBeePoints;

            // 레벨 계산
            double calculatedPoints = totalPoints - totalBeePoints;
            if (calculatedPoints >= 0 && calculatedPoints <= 25) {
              pointModel.level = 1;
            } else if (calculatedPoints <= 50) {
              pointModel.level = 2;
            } else if (calculatedPoints <= 75) {
              pointModel.level = 3;
            } else if (calculatedPoints <= 90) {
              pointModel.level = 4;
            } else {
              pointModel.level = 5;
            }

            rxPointModel.value = pointModel;
          }
        }
      }
    } catch (e) {
      print('fetch: $e');
    }
  }

  /////////////////////////////////////////////////////////////
  // QR 찍었을 때 점수 추가
  Future<void> attendQR(UserModel user, int attendPoint) async {
    String? pid = user.pid;
    DocumentReference pointsRef =
        FirebaseFirestore.instance.collection('points').doc(pid); //user's pid

    // Fetch the current points data
    DocumentSnapshot pointsSnapshot = await pointsRef.get();
    Timestamp currentTime = Timestamp.fromDate(DateTime.now());

    Map<String, dynamic> newPoint = {
      'digit': attendPoint,
      'reason': '정상출석',
      'timestamp': currentTime,
      'type': '출결'
    };

    if (pointsSnapshot.exists) {
      Map<String, dynamic> existingPoints =
          pointsSnapshot.data() as Map<String, dynamic>;
      await pointsRef.update({
        'points': FieldValue.arrayUnion([newPoint])
      });
    } else {
      await pointsRef.set({
        'points': [newPoint]
      });
    }

    fetchAndSortUserPoints();
    fetchCurrentUserPoints();
  }

  /////////////////////////////////////////////////////////////
  //QR 지각했을 때
  Future<void> lateQR(UserModel user, int attendPoint) async {
    String? pid = user.pid;
    DocumentReference pointsRef =
        FirebaseFirestore.instance.collection('points').doc(pid); //user's pid

    // Fetch the current points data
    DocumentSnapshot pointsSnapshot = await pointsRef.get();
    Timestamp currentTime = Timestamp.fromDate(DateTime.now());

    Map<String, dynamic> newPoint = {
      'digit': attendPoint,
      'reason': '지각',
      'timestamp': currentTime,
      'type': '출결'
    };

    if (pointsSnapshot.exists) {
      Map<String, dynamic> existingPoints =
          pointsSnapshot.data() as Map<String, dynamic>;
      await pointsRef.update({
        'points': FieldValue.arrayUnion([newPoint])
      });
    } else {
      await pointsRef.set({
        'points': [newPoint]
      });
    }

    fetchAndSortUserPoints();
    fetchCurrentUserPoints();
  }
}
