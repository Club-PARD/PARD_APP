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
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 final PushNotificationController pnc = PushNotificationController.to;

  @override
  void initState(){
    super.initState();
     FirebaseMessaging.onMessage.listen((message) {   /** foreground 수신처리 */
  PushNotificationController.showFlutterNotification(  /** 알림 보여주게 한다 */
      message, 
      pnc.flutterLocalNotificationsPlugin, 
      pnc.channel
  );
});   
     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler); /** bacjground 수신처리 */
     FirebaseMessaging.onMessageOpenedApp.listen(pnc.handleMessage);   /** 알림 클릭 */
  }

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
