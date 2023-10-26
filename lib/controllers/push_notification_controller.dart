import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/user_controller.dart';

class PushNotificationController extends GetxController {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  static PushNotificationController get to => Get.find();
  late UserController userController = Get.put(UserController());
  late String? uid = userController.userInfo.value?.uid;

  /// 앱 어디서든지 접근 가능하게
  late final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;
  var fcmTokenUser = ''.obs;

  //fcm 기본 설정
  Future<void> setupFlutterNotifications() async {
    //device token얻기 
    // fcmToken = await firebaseMessaging.getToken();
    
    //안드로이드 백그라운드 채널
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // iOS foreground notification 권한
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
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

    print('********#&#*&*#&%*#&*%#');
    print(uid);
    print(fcmToken);
    print(userController.userInfo.value);
  }

  Future<void> getToken() async {
    final fcmToken = await firebaseMessaging.getToken();
    fcmTokenUser.value = await firebaseMessaging.getToken() ?? '';

    // /**공지 받으려면 기기의 토큰 받아와야 한다 */
    print("--------TOKEN--------------");
    print('');
    print('');
    print('');
    print('');
    print('');
    print('');
    print('');
    print('');
    print(fcmToken);
    print("--------TOKEN--------------");
  }

  /// FCM이 notification으로 올 경우
  void showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    String? title = message.notification!.title;
    String? description = message.notification!.body;

    final UserController userController = Get.put(UserController());
    String? uid = userController.userInfo.value?.uid;
    bool? onOff =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get())
            .data()?['onOff'];

    print('onOff : ${onOff!}');

    if (notification != null && android != null) {
      // 웹이 아니면서 안드로이드이고, 알림이 있는경우, user의 파베에 저장된 onOff의 값이 true일경우 
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'noti_icon',
          ),
        ),
      );
    }
  }
}
