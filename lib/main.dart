import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/firebase_options.dart';
import 'package:pard_app/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final UserController userController = Get.put(UserController());
  print('******************백그라운드 시작***********************');

  final pushController = PushNotificationController(); // 셋팅 메소드
  await pushController.setupFlutterNotifications();
  pushController.showFlutterNotification(message); // 로컬노티
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    await initializeDateFormatting('ko_KR', null);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("--------------초기화 성공-----------");
  } catch (error) {
    print("실패 : $error");
  }
  FirebaseMessaging.instance.requestPermission();
  Get.put(PushNotificationController());
  /** pushNotificationController에 있는것들 사용한다 */
  await PushNotificationController.to.setupFlutterNotifications();

  FirebaseMessaging.onMessage
      .listen(PushNotificationController.to.showFlutterNotification);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

UserController.init();
  Get.put(BottomBarController());
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}
