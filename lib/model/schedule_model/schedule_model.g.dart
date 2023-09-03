// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      Map<String, int>.from(json['attend'] as Map),
      json['title'] as String,
      json['description'] as String,
      DateTime.parse(json['dueDate'] as String),
      json['place'] as String,
      json['part'] as String,
      json['previous'] as bool,
      json['sid'] as String,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'attend': instance.attend,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate.toIso8601String(),
      'place': instance.place,
      'part': instance.part,
      'previous': instance.previous,
    };