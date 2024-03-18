import 'package:intl/intl.dart';

class SpringScheduleModel {
  final String? title;
  final DateTime? scheduleDate;
  final String? content;
  final String? part;
  final String? place;

  SpringScheduleModel({this.title, this.scheduleDate, this.content, this.part, this.place});

  factory SpringScheduleModel.fromJson(Map<String, dynamic> json) {
    return SpringScheduleModel(
      title: json['title'],
      scheduleDate: DateTime.parse(json['scheduleDate']),
      content: json['content'],
      part: json['part'],
      place: json['place'], 
    );
  }

  String getFormattedScheduleDate() {
    if (scheduleDate == null) return '';
    return DateFormat('yyyy-MM-dd HH:mm').format(scheduleDate!);
  }
}
