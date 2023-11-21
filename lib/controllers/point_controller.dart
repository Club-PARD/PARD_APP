import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/error_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/model/point_model/point_model.dart';
import 'package:pard_app/model/user_model/user_model.dart';

class PointController extends GetxController {
  final UserController _userController = Get.put(UserController());
  final ErrorController _errorController = Get.put(ErrorController());
  RxMap userPointsMap = {}.obs; // Data Type: UserModel, Double
  Rx<PointModel?> rxPointModel = Rx<PointModel?>(null);
  RxInt currentUserRank = 0.obs;
  RxInt currentUserPartRank = 0.obs;

  /////////////////////////////////////////////////////////////
  // 모든 멤버의 포인트를 계산하고 내림차순으로 정렬
  Future<void> fetchAndSortUserPoints() async {
    try {
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
        DocumentSnapshot pointsSnapshot = await FirebaseFirestore.instance
            .collection('points')
            .doc(pid)
            .get();

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
        }

        resultMap[user] = totalPoints;
      });

      // 정렬 후, resultMap을 userPointsMap으로 업데이트
      resultMap = Map.fromEntries(resultMap.entries.toList()
        ..sort((e1, e2) => e2.value.compareTo(e1.value)));

      // RxMap을 업데이트
      userPointsMap.assignAll(resultMap);
      getCurrentUserRank();
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'fetchAndSortUserPoints()',
      );
    }
  }

  /////////////////////////////////////////////////////////////
  // 현재 유저의 등수를 반환하는 함수
  Future<void> getCurrentUserRank() async {
    try {
      final Map<UserModel, double> userPointsMapCopy = Map.from(userPointsMap);
      List<UserModel> sortedUsers = userPointsMapCopy.keys.toList();

      sortedUsers.sort(
          (a, b) => userPointsMapCopy[b]!.compareTo(userPointsMapCopy[a]!));

      int currentUserIndex = sortedUsers.indexWhere(
          (user) => user.email == _userController.userInfo.value!.email);
      if (currentUserIndex != -1) {
        currentUserRank.value = currentUserIndex + 1;
      }

      print('currentUserRank: ${currentUserRank.value}');
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'getCurrentUserRank()',
      );
    }
  }

  /////////////////////////////////////////////////////////////
  // 현재 유저의 파트 내 등수를 반환하는 함수
  Future<void> getCurrentUserPartRank() async {
    try {
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

      List<MapEntry<UserModel, double>> samePartEntries = sortedEntries
          .where(
              (entry) => entry.key.part == _userController.userInfo.value!.part)
          .toList();

      int rank = samePartEntries.indexWhere(
          (entry) => entry.key.name == _userController.userInfo.value!.name);

      if (rank != -1) {
        currentUserPartRank.value = rank + 1;
      }

      print('currentUserPartRank: ${currentUserPartRank.value}');
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'getCurrentUserPartRank()',
      );
    }
  }

  /////////////////////////////////////////////////////////////
  // 현재 유저의 포인트 & 벌점를 가져오는 함수
  Future<void> fetchCurrentUserPoints() async {
    try {
      // users 컬렉션에서 해당 이메일에 해당하는 문서를 찾기
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _userController.userInfo.value!.email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        String uid = userSnapshot.docs[0]['uid'];
        String pid = userSnapshot.docs[0]['pid'];
        double totalPointsFromAttendInfo = 0;

        // points 컬렉션에서 해당 pid에 해당하는 문서 가져오기
        DocumentSnapshot pointsSnapshot = await FirebaseFirestore.instance
            .collection('points')
            .doc(pid)
            .get();

        // users 컬렉션에서 해당 pid에 해당하는 문서 가져오기
        DocumentSnapshot userDocumentSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDocumentSnapshot.exists) {
          Map<String, dynamic> userData =
              userDocumentSnapshot.data() as Map<String, dynamic>;

          if (userData.containsKey('attendInfo')) {
            Map<String, dynamic> attendInfo = userData['attendInfo'];

            attendInfo.forEach((key, value) {
              print('key: $key, value: $value');
              switch (value) {
                case '출':
                  totalPointsFromAttendInfo += 6;
                  break;
                case '지':
                  totalPointsFromAttendInfo += 4;
                  break;
                case '결':
                  totalPointsFromAttendInfo += 0;
                  break;
              }
            });
          }
        }

        if (pointsSnapshot.exists) {
          PointModel pointModel = PointModel.fromJson(
              pointsSnapshot.data() as Map<String, dynamic>);

          double totalPoints = 0;
          double totalBeePoints = 0;

          // if (pointModel.points != null) {
          //   for (var point in pointModel.points!) {
          //     totalPoints += (point['digit']  ?? 0);
          //   }
          // }

          // if (pointModel.beePoints != null) {
          //   for (var beePoint in pointModel.beePoints!) {
          //     totalBeePoints += (beePoint['digit'] ?? 0);
          //   }
          // }

          if (pointModel.points != null) {
            for (var point in pointModel.points!) {
              totalPoints +=
                  (point['digit'] as Map<String, dynamic>)['value'] ?? 0;
            }
          }

          if (pointModel.beePoints != null) {
            for (var beePoint in pointModel.beePoints!) {
              totalBeePoints +=
                  (beePoint['digit'] as Map<String, dynamic>)['value'] ?? 0;
            }
          }

          pointModel.currentPoints = totalPoints;
          pointModel.currentBeePoints = totalBeePoints;

          // 레벨 계산
          double calculatedPoints = totalPoints + totalPointsFromAttendInfo;
          print('calculatedPoints: $calculatedPoints');
          if (calculatedPoints >= 0 && calculatedPoints <= 30) {
            pointModel.level = 1;
          } else if (calculatedPoints <= 55) {
            pointModel.level = 2;
          } else if (calculatedPoints <= 80) {
            pointModel.level = 3;
          } else if (calculatedPoints <= 95) {
            pointModel.level = 4;
          } else {
            pointModel.level = 5;
          }

          rxPointModel.value = pointModel;
        }
      }
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'fetchCurrentUserPoints()',
      );
    }
  }

  /////////////////////////////////////////////////////////////
  // QR 찍었을 때 점수 추가
  Future<void> attendQR(UserModel user, int attendPoint) async {
    try {
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

      await fetchAndSortUserPoints();
      await fetchCurrentUserPoints();
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'attendQR()',
      );
    }
  }

  /////////////////////////////////////////////////////////////
  //QR 지각했을 때
  Future<void> lateQR(UserModel user, int attendPoint) async {
    try {
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

      await fetchAndSortUserPoints();
      await fetchCurrentUserPoints();
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'lateQR()',
      );
    }
  }
}
