// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String?,
<<<<<<< Updated upstream
=======
      pid: json['pid'] as String?,
>>>>>>> Stashed changes
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      part: json['part'] as String?,
      member: json['member'] as String?,
      generation: json['generation'] as int?,
      isAdmin: json['isAdmin'] as bool?,
      isMaster: json['isMaster'] as bool?,
<<<<<<< Updated upstream
      lastLogin: dateTimeFromTimestamp(json['lastLogin'] as Timestamp),
      attend: json['attend'] as Map<String, dynamic>?,
    )..pid = json['pid'] as String?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
=======
      lastLogin: dateTimeFromTimestamp(json['lastLogin'] as Timestamp?),
      attend: json['attend'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'pid': instance.pid,
>>>>>>> Stashed changes
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'part': instance.part,
      'member': instance.member,
      'generation': instance.generation,
      'isAdmin': instance.isAdmin,
      'isMaster': instance.isMaster,
      'lastLogin': instance.lastLogin?.toIso8601String(),
<<<<<<< Updated upstream
      'pid': instance.pid,
=======
>>>>>>> Stashed changes
      'attend': instance.attend,
    };
