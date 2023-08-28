import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/firebase_options.dart';
import 'package:pard_app/my_app.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  bool? onOff = (await FirebaseFirestore.instance
          .collection('notification_controller')
          .doc('notification')
          .get())
      .data()?['onOff'];
  print('******************백그라운드 시작***********************'); /** 안드로이드에서만 나오고 ios는 안나옴 */
  final pushController = PushNotificationController(); // 셋팅 메소드
  await pushController.setupFlutterNotifications();
  pushController.showFlutterNotification(message);  // 로컬노티
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("--------------초기화 성공-----------");
  } catch (error) {
  print("실패 : $error");
}

  Get.put(PushNotificationController()); /** pushNotificationController에 있는것들 사용한다 */
  // await PushNotificationController.to.setupFlutterNotifications();
  FirebaseMessaging.onMessage.listen(PushNotificationController.to. showFlutterNotification);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final BottomBarController bottomBarController = Get.put(BottomBarController());

  runApp(const MyApp());
}
