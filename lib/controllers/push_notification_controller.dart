import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotificationController extends GetxController {
  static PushNotificationController get to => Get.find(); /// 앱 어디서든지 접근 가능하게
  late final FirebaseMessaging firebaseMessaging;  /// 알림 처리하는데 사용할 변수
  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();

  @override
  void onInit() {
    /** 첫 빌드 할때 ios-권한 필수, and - 상관x -> requestNotificationPermission  */
    firebaseMessaging = FirebaseMessaging.instance;
    initFirebaseMessaging();          
    requestNotificationPermission();  /**알림 요청 */
    getToken();
    //onMessage();
    super.onInit();
  }

    initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { /**앱 활성화된 상태 */
    this.message.value = message; /**message값 업데이트 */
      RemoteNotification? notification = message.notification;
      if (notification != null) { /**서버로부터 알림이 온 상태일 때  */
        print('알림 왔음 (foreground 상태): ${notification.body}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) { /**백그라운드 상태일 때  */
    this.message.value = message; /**message 값 업데이트 */
      print(' 알림 왔음 (Background 상태) :  ${message.data}'); /**message.data는 알림에 담긴 내용  */
    });
  }

  requestNotificationPermission() async { /**사용자에게 알림 보낼 권한 요청 */
    /**사용자의 응답 settings에 저장 */
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    /**사용자가 권한 승낙했는지 안했는지 확인 */
    switch (settings.authorizationStatus) {
  case AuthorizationStatus.authorized:
    print('파디들이 동의함');
    break;
  case AuthorizationStatus.denied:
    print('파디들이 권한주기 싫다고 거정함 ㅠ');
    break;
      default:
    print('${settings.authorizationStatus}');
}
  }

  getToken() async{
    final fcmToken = await firebaseMessaging.getToken(); /**공지 받으려면 기기의 토큰 받아와야 한다 */
    print(fcmToken);
  }
  /// 안드로이드는 알림 위한 채널 있어야 한다
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'PARD 공지 채널', // description
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

//   void onMessage() async{
// await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     // 2.
//     await flutterLocalNotificationsPlugin.initialize(
//         const InitializationSettings(
//             android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: IOSInitializationSettings()),
//         onSelectNotification: (String? payload) async {});
//   }
}
