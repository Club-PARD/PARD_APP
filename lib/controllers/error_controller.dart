import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// 에러 상태 관리 컨트롤러
class ErrorController extends GetxController {
  var deviceInfo = DeviceInfoPlugin();
  var androidInfo;
  var iosInfo;

  /// 에러 로그 작성
  Future<void> writeErrorLog(String log, String phoneNum, dynamic about,
      {bool isWidgetLog = false}) async {
    var errorLog;
    if (GetPlatform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      if (kDebugMode) {
        print('Running on ${androidInfo.model}');
      }
    } else {
      iosInfo = await deviceInfo.iosInfo;
      if (kDebugMode) {
        print('Running on ${iosInfo.utsname.machine}');
      }
    }

    if (isWidgetLog) {
      errorLog = [];
      var parsedLogList = log.split(' ');
      for (var i = 0; i < parsedLogList.length; i++) {
        if (parsedLogList[i].startsWith('(package:pard_app_project/')) {
          var temp = parsedLogList[i]
              .toString()
              .substring(1, parsedLogList[i].toString().length - 4);
          errorLog.add(temp);
        }
      }
    } else {
      errorLog = log;
    }

    if ((isWidgetLog && errorLog.length > 1) || !isWidgetLog) {
      await FirebaseFirestore.instance.collection('Errorlog').doc().set({
        'phoneNum': phoneNum,
        'about': about,
        'log': errorLog,
        'time': DateTime.now(),
        'model':
            GetPlatform.isAndroid ? androidInfo.model : iosInfo.utsname.machine
      });
    }
  }
}
