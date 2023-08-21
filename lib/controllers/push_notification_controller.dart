import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../model/notification_model.dart';

class PushNotificationController extends GetxController {
  static PushNotificationController get to => Get.find();

  /// 앱 어디서든지 접근 가능하게
  late final FirebaseMessaging firebaseMessaging;

  /// 알림 처리하는데 사용할 변수
  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();
  var inform = RxList<NotificationModel>();
  /** 메세지 온거 제목,내용 등 inform에 저장 */
  /// 안드로이드는 알림을 foreground, background 상관 없이 채널을 통해서 알림 보내야 한다
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;
  var onOff = true.obs;

  /// 처음에 true라고 가정

  @override
  void onInit() {
    requestNotificationPermission().then((status) {
      if (status == AuthorizationStatus.authorized) {
        onOff.value = true; /** 권한 수락했으면 onOff켜짐 */
      } else {
        onOff.value = false; /** 권한 거절했으면 onOff꺼져있다 */
      }
    });
    /** 첫 빌드 할때 ios-권한 필수, and - 상관x -> requestNotificationPermission  */
    firebaseMessaging = FirebaseMessaging.instance;
    initFirebaseMessaging();
    /** 알림 내용 다루는 것 */
    getToken();

    /** 원래 getX로 onOff값 이용해서 알림 수신 결정하려고 했는데 background상태에서는 getX를 사용할 수 없어서 firestore에 onOff값 저장하고
     * 백그라운드 상태에서는 fcm오면 firestore에서 onOff.value와 비교 후 값 올지 안올지 결정
     */
    ever(onOff, (value) async {
      await FirebaseFirestore.instance.collection('알림').doc('notification').set({
        'onOff': value
      });
    });

    super.onInit();
  }

  /// 사용자에게 알림 보낼 권한 요청 앱 시작하면서 불린다
  Future<AuthorizationStatus> requestNotificationPermission() async {
    ///안드로이드 채널 만들기
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

    // IOS background 권한 체킹 , 요청 settings에 저장
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
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
        return settings.authorizationStatus;
      case AuthorizationStatus.denied:
        print('파디들이 거정함');
        return settings.authorizationStatus;
      default:
        print('${settings.authorizationStatus}');
        return settings.authorizationStatus;
    }
  }

  initFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /**앱 활성화된 상태(foreground) 콘솔에서 보낸 알림 message로 받아옴*/
      this.message.value = message;
      /**message값 업데이트 */
      RemoteNotification? notification = message.notification;

      if (notification != null && onOff.value) {
        /**서버로부터 알림이 온 상태이고, 알림 켜놨을 때  */
        print('알림 왔음 (foreground 상태): ${notification.body}');
        /** 새로운 알림 올때마다 NotificationModel객체 생성해서 notifications list에 추가 */
      }
      inform.add(NotificationModel(
        onOff,
        /** 알림이 활성환 된 상태 */
        notification?.title ?? "No Title",
        /** 제목 null이면 No title 있으면 제목 */
        notification?.body ?? "No Content",
        /** 본문이 null이면 No Content */
        DateTime.now(), /** 현재 시간과 날짜 저장 */
      ));
    });
  }

  /// android 최신 버전은 알림 주려면 통로같은거를 뚫어서 거기서 기기에 알림 보내줘야 한다 함
  static void showFlutterNotification(
      RemoteMessage message,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      AndroidNotificationChannel channel) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null &&
        android != null &&
        !kIsWeb &&
        PushNotificationController.to.onOff.value == true) {
      // 웹이 아니면서 안드로이드이고, push_notification의 onOff가 true인경우
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
      print(' 알림 왔음 (Background 상태) :  ${notification.body}');
    }
  }

  getToken() async {
    final fcmToken = await firebaseMessaging.getToken();
    /**공지 받으려면 기기의 토큰 받아와야 한다 */
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print(fcmToken);
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    print("--------TOKEN--------------");
    if (fcmToken != null) {
      final tokenRef =
          FirebaseFirestore.instance.collection('tokens').doc(fcmToken);

      /** Firestore에 있는 토큰 fetch */
      DocumentSnapshot existingTokenDoc = await tokenRef.get();
      Map<String, dynamic>? data =
          existingTokenDoc.data() as Map<String, dynamic>?;
      String? existingToken = data?['token'] as String?;
      /** 갱신된 토근이거나 기존에 있는 토큰이 아닌경우 firesotre에 등록 */
      if (!existingTokenDoc.exists || (existingToken != fcmToken)) {
        tokenRef.set({
          'token': fcmToken,
        });
      }
    }
  }

  /// 알림 클릭했을 때
  void handleMessage(RemoteMessage message) {}
}
