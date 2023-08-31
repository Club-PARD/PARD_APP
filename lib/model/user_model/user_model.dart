import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pard_app/model/convert_datetime.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.uid,
<<<<<<< Updated upstream
=======
    this.pid,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
  });

  String? uid;
=======
    this.fcmToken,
  });

  String? uid;
  String? pid;
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
  String? pid;
  Map<String, dynamic>? attend;
=======
  Map<String, dynamic>? attend;
  String ?fcmToken;
>>>>>>> Stashed changes

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
