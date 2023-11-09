import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/error_controller.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/model/user_model/user_model.dart';

class UserController extends GetxController {
  final ErrorController _errorController = Get.put(ErrorController());
  final CollectionReference<Map<String, dynamic>> usersCollection =
      FirebaseFirestore.instance.collection('users');
  Rx<UserModel?> userInfo = Rx<UserModel?>(null);
  Rx<String?> deviceName = Rx<String?>(null);
  Rx<String?> deviceVersion = Rx<String?>(null);
  Rx<String?> fcmToken = Rx<String?>(null);
  late Rx<bool?> onOff = Rx<bool?>(null);
  Rx<String?> uid = Rx<String?>(null);
  late final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static void init() {
    Get.put(UserController());
  }

  //user모델 가져오기(by 이메일)
  Future<void> getUserInfoByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs.first.data();

        UserModel user = UserModel.fromJson(userData);
        onOff.value = user.onOff;

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
        print('pid: ${user.pid}');
        print('attend: ${user.attend}');
        print('fcmToken : ${user.fcmToken}');
        print('onOff : ${user.onOff}');
        userInfo.value = user;

        String? token = PushNotificationController.to.fcmTokenUser.value;
        await updateFcmToken(user, token);
      } else {
        print('사용자 정보 없음');
      }
    } catch (e) {
      print("Error while fetching user info: $e");
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'getUserInfoByEmail()',
      );
    }
  }

  //유저의 Email이 저장되어 있는지 (휴대폰 인증이 필요한지) 체크
  Future<bool> isVerifyUserByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();
          
      return querySnapshot.docs.isNotEmpty;
      //true 반환
    } catch (e) {
      print("Error while verifying user by email: $e");
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'isVerifyUserByEmail()',
      );
      return false;
    }
  }

  //이메일 저장(휴대폰 인증 성공시 사용 함수)
  Future<void> saveEmail(String uid, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'email': email,
      });
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'saveEmail()',
      );
    }
  }

  Future<void> saveOnOff(String uid, bool onOff) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'onOff': onOff,
      });
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'saveOnOff()',
      );
    }
  }

  Future<void> updateAttend(UserModel user, String? qrCode) async {
    final currentTime = DateTime.now().toIso8601String();
    final userDocument =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    try {
      await userDocument.update({
        'attend': {qrCode: currentTime}
      });
    } catch (e) {
      print(e);
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'updateAttend()',
      );
    }
  }

//FcmToken 파베에 업데이트
  Future<void> updateFcmToken(UserModel user, String token) async {
    var pushController = Get.find<PushNotificationController>();
    fcmToken.value = token;
    final usersCollection = FirebaseFirestore.instance.collection('users');
    print('11111111111111111111111');
    print("FcmToken is: ${pushController.fcmTokenUser.value}");
    try {
      print('11111111111111111111111');
      print(userInfo.value?.uid);
      await usersCollection.doc(user.uid).update({'fcmToken': fcmToken.value});
      print("fcmToken updated in Firestore");
    } catch (e) {
      print("Failed to update fcmToken: $e");
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'updateFcmToken()',
      );
    }
  }

  //로그인 기록 업데이트(by 이메일) - 휴대폰 인증 성공시, 휴대폰 인증 완료 후 다시 로그인 할 때,
  Future<void> updateTimeByEmail(String email) async {
    final currentTime = Timestamp.now();

    try {
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
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'updateTimeByEmail()',
      );
    }
  }

  //휴대폰 인증 성공시
  Future<void> setUserByEmail(String email) async {
    final currentTime = Timestamp.now();
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      final querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;
        await userDoc.reference.update({
          'lastLogin': currentTime,
          'attend': <String, dynamic>{},
          'onOff': true,
        });
        print('유저세팅성공 $email');
      } else {
        print('사용자를 찾을 수 없습니다: $email');
      }
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'setUserByEmail()',
      );
    }
  }

  Future<void> addAttend(String sid, String attend) async {
    final userDocument =
        FirebaseFirestore.instance.collection('users').doc(userInfo.value!.uid);

    try {
      final userSnapshot = await userDocument.get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        userData['attend'] ??= <String, dynamic>{};
        userData['attend'][sid] = attend;
        await userDocument.update({'attend': userData['attend']});
      }
    } catch (e) {
      print(e);
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'addAttend()',
      );
    }
  }

  Future<void> addAttendInfo(String attend) async {
    final userDocument =
        FirebaseFirestore.instance.collection('users').doc(userInfo.value!.uid);
    try {
      await userDocument.update({
        'attendInfo': FieldValue.arrayUnion([attend])
      });
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'addAttendInfo()',
      );
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
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'getDeviceInfo()',
      );
    }
  }

  Future<bool> hasAlreadyScannedToday(UserModel? user, String? qrCode) async {
    //찍은 qrCode 받아서
    String? pid = user?.pid;
    Timestamp? latestAttend;
    var pointsRef = await FirebaseFirestore.instance
        .collection('points')
        .doc(pid)
        .get(); //points collection에서 user의 pid찾아서 pointsRef로 저장
    print('hasAlreadyScanned에서 주현의 pid : $pid');
    print('hasAlreadyScanned에서 pid로 불러온 firestore: $pointsRef');

    Map<String, dynamic>? data = pointsRef.data();
    //pid안에 map에 points라는 배열 있으면 해당 배열 pointsArray에 저장
    try {
      if (data != null && data.containsKey('points')) {
        List<dynamic>? pointsArray = data['points'];

        // timeStamp라는 것 가지고 있다면 가장 최신꺼 가져옴
        if (pointsArray != null && pointsArray.isNotEmpty) {
          var latestPoint = pointsArray.last;

          if (latestPoint is Map && latestPoint.containsKey('timestamp')) {
            latestAttend = latestPoint['timestamp'];
          }
        } else if (pointsArray == null) {
          print('pointsArray가 null');
        }
      }

      //최신 출석 timeStamp 구했고, 값이 있으면 오늘 날짜와 비교해서 오늘 찍은 기록이 있으면 true 반환
      if (latestAttend != null) {
        DateTime latestAttendDateTime = latestAttend.toDate();
        DateTime now = DateTime.now();

        DateTime latestAttendDate = DateTime(latestAttendDateTime.year,
            latestAttendDateTime.month, latestAttendDateTime.day);
        DateTime currentDate = DateTime(now.year, now.month, now.day);

        if (latestAttendDate.isAtSameMomentAs(currentDate)) {
          return true;
        }
      }
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value!.phone ?? 'none',
        'hasAlreadyScannedToday()',
      );
    }
    //아니면 false 반환
    return false;
  }
}
