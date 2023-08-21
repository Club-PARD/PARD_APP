import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/qr_scanner.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/view/home.dart';
import 'package:pard_app/view/mypage.dart';
import 'firebase_options.dart';

/// 앱 종료된 상태거나 백그라운드에 있을경우
/// channel이라는 개구멍 만들어서 알림들 보냄
/// fcm에서 백그라운드 알림을 받았을 때 앱에서 해당 알림을 로컬 알림으로 표시하기 위한 처리를 하는 함수
@pragma('vm:entry-point')

/// 앱이 종료되거나 백그라운드에 있어도 fcm을 받을 수 있다
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool? onOff = (await FirebaseFirestore.instance
          .collection('알림')
          .doc('notification')
          .get())
      .data()?['onOff'];

  /** 앱 꺠우기 */
  print("message data: ${message.notification?.body}");
  print('firestore의 onOff값 : ${onOff}');
  /** 백그라운드 값 받음 */

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  if (onOff == true) /** firestore에서 notification 필드에 있는 onOff의 값이 true일때만 보여준다 */
  {
    PushNotificationController.showFlutterNotification(
        message, flutterLocalNotificationsPlugin, channel);
  }
  Get.to(const Home());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(PushNotificationController());
  /** pushNotifiaction controller초기화되지 않았다고 해서 초기화 */
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final PushNotificationController pnc = PushNotificationController.to;

  FirebaseMessaging.onMessage.listen((message) {
    PushNotificationController.showFlutterNotification(
        message, pnc.flutterLocalNotificationsPlugin, pnc.channel);
  });

  FirebaseMessaging.onMessageOpenedApp.listen(pnc.handleMessage);
  /** background상태에서 알림 누르면 앱 실행 */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder.put(() => PushNotificationController(),
          permanent: true),
      home: const Home(),
      /** 초기 페이지 mypage.dart로 설정 */
      getPages: [
        /** router */
        GetPage(name: '/mypage', page: () => const MyPage()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/qr', page: () => const QRScannerPage())
      ],
    );
  }
}
