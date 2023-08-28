import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pard_app/model/convert_datetime.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.phone,
    this.email,
    this.part,
    this.member,
    this.generation,
    this.isAdmin,
    this.isMaster,
    this.lastLogin,
    this.attend,
    this.fcmTOKEN,
  });

  String? uid;
  String? name;
  String? phone;
  String? email;
  String? part;
  String? member;
  int? generation;
  bool? isAdmin;
  bool? isMaster;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime? lastLogin;
  String? pid;
  Map<String, dynamic>? attend;
  String ?fcmTOKEN;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
