// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      json['title'] as String,
      DateTime.parse(json['dueDate'] as String),
      json['place'] as String,
      json['part'] as String,
      json['previous'] as bool,
      json['sid'] as String,
      json['type'] as bool,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dueDate': instance.dueDate.toIso8601String(),
      'place': instance.place,
      'part': instance.part,
      'previous': instance.previous,
      'sid': instance.sid,
      'type': instance.type,
    };
