// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointModel _$PointModelFromJson(Map<String, dynamic> json) => PointModel(
      json['uid'] as String?,
      json['pid'] as String?,
      (json['points'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      (json['beePoints'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$PointModelToJson(PointModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'pid': instance.pid,
      'points': instance.points,
      'beePoints': instance.beePoints,
    };
