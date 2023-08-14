import 'package:get/get.dart';

class NotificationModel{
  RxBool onOff;
  String title;
  String content;
  DateTime time;
  NotificationModel(
    this.onOff,
    this.title,
    this.content,
    this.time
  ); /** switch와 연결해서 getX로 상태관리 할거여서 Rxbool로 연결한다 */
  // 디버깅 용으로 작성
  // @override
  // String toString() {
  //   return 'OnOff: $onOff, Title: $title, Content: $content, Time: ${time.toLocal()}';
  // }
}
