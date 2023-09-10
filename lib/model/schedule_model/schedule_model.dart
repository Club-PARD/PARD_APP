import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  ScheduleModel(this.title, this.description, this.dueDate, this.place,
      this.part, this.previous, this.sid);

  String title;
  String description;
  DateTime dueDate;
  String place;
  String part;
  bool previous;
  String sid;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
