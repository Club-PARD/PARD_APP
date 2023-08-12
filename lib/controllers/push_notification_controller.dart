import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../model/notification_model.dart';

class PushNotificationController extends GetxController {
  static PushNotificationController get to => Get.find(); /// 앱 어디서든지 접근 가능하게
  late final FirebaseMessaging firebaseMessaging;  /// 알림 처리하는데 사용할 변수
  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();
  var inform = RxList<NotificationModel>();

  @override
  void onInit() {
    /** 첫 빌드 할때 ios-권한 필수, and - 상관x -> requestNotificationPermission  */
    firebaseMessaging = FirebaseMessaging.instance;
    initFirebaseMessaging();          
    requestNotificationPermission();  /**알림 요청 */
    getToken();
    super.onInit();
  }

    initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { /**앱 활성화된 상태 콘솔에서 보낸 알림 message로 받아옴*/
    this.message.value = message; /**message값 업데이트 */
      RemoteNotification? notification = message.notification;


      if (notification != null) { /**서버로부터 알림이 온 상태일 때  */
        print('알림 왔음 (foreground 상태): ${notification.body}');
        /** 새로운 알림 올때마다 NotificationModel객체 생성해서 notifications list에 추가 */
        inform.add(
          NotificationModel(
            true,                              /** 알림이 활성환 된 상태 */
            notification.title ?? "No Title",  /** 제목 null이면 No title 있으면 제목 */
            notification.body ?? "No Content", /** 본문이 null이면 No Content */
            DateTime.now(),                    /** 현재 시간과 날짜 저장 */
          )
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) { /**백그라운드 상태일 때  */
    this.message.value = message; /**message 값 업데이트 */
      print(' 알림 왔음 (Background 상태) :  ${message.data}'); /**message.data는 알림에 담긴 내용 에뮬레이터 한정 출력 잘됨 */
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
    if (fcmToken != null) {
    final tokenRef = FirebaseFirestore.instance.collection('tokens').doc(fcmToken);

    /** Firestore에 있는 토큰 fetch */
    DocumentSnapshot existingTokenDoc = await tokenRef.get();
    Map<String, dynamic>? data = existingTokenDoc.data() as Map<String, dynamic>?;
    String? existingToken = data?['token'] as String?;
    /** 갱신된 토근이거나 기존에 있는 토큰이 아닌경우 firesotre에 등록 */
    if (!existingTokenDoc.exists || (existingToken != fcmToken)) {
    tokenRef.set({
        'token': fcmToken,
    });
}

  }
  }
 
}
