import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotificationController extends GetxController {
    late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    late AndroidNotificationChannel channel;
    static PushNotificationController get to => Get.find();
  /// 앱 어디서든지 접근 가능하게
  late final FirebaseMessaging firebaseMessaging =FirebaseMessaging.instance;

    Future<void> setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  // iOS foreground notification 권한
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // IOS background 권한 체킹 , 요청
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  
  // 토큰 요청
  getToken();
  // 셋팅flag 설정
} 

  Future<void> getToken() async{
    final fcmToken = await firebaseMessaging.getToken();
    /**공지 받으려면 기기의 토큰 받아와야 한다 */
    print("--------TOKEN--------------");
    print(fcmToken);
    print("--------TOKEN--------------");
  }
  /// FCM이 notification으로 올 경우
  void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) { // 웹이 아니면서 안드로이드이고, 알림이 있는경우
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
 
          icon: 'launch_background',
        ),
      ),
    );
  }
  /** fcm이 data로 올경우 */
  Map<String, dynamic> data = message.data;
  if (data.isNotEmpty) {
    print(message.data);
  }

}

}





