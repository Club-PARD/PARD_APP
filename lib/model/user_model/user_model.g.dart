// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      part: json['part'] as String?,
      member: json['member'] as String?,
      generation: json['generation'] as int?,
      isAdmin: json['isAdmin'] as bool?,
      isMaster: json['isMaster'] as bool?,
      lastLogin: dateTimeFromTimestamp(json['lastLogin'] as Timestamp),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'part': instance.part,
      'member': instance.member,
      'generation': instance.generation,
      'isAdmin': instance.isAdmin,
      'isMaster': instance.isMaster,
      'lastLogin': instance.lastLogin?.toIso8601String(),
    };
