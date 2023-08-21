import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/view/home.dart';
import 'package:pard_app/view/mypage.dart';
import 'firebase_options.dart';

/// 앱 종료된 상태거나 백그라운드에 있을경우
/// channel이라는 개구멍 만들어서 알림들 보냄 
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Display the notification
  PushNotificationController.showFlutterNotification(message, flutterLocalNotificationsPlugin, channel);
}

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(PushNotificationController()); /** pushNotifiaction controller초기화되지 않았다고 해서 초기화 */
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final PushNotificationController pnc = PushNotificationController.to;
  
  FirebaseMessaging.onMessage.listen((message) {
    PushNotificationController.showFlutterNotification(
      message, 
      pnc.flutterLocalNotificationsPlugin, 
      pnc.channel
    );
  });
  
  FirebaseMessaging.onMessageOpenedApp.listen(pnc.handleMessage);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder.put(() => PushNotificationController(),permanent: true),
      home: const Home(),    /** 초기 페이지 mypage.dart로 설정 */
      getPages: [              /** router */
        GetPage(name: '/mypage', page: () => const MyPage()),
        GetPage(name: '/home', page: () => const Home())
      ],
    );
  }
}
