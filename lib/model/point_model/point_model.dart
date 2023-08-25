import 'package:json_annotation/json_annotation.dart';

part 'point_model.g.dart';

@JsonSerializable()
class PointModel {
  PointModel(this.uid, this.pid, this.points, this.beePoints);

  String? uid;
  String? pid;
  List<Map>? points;
  List<Map>? beePoints;

  factory PointModel.fromJson(Map<String, dynamic> json) =>
      _$PointModelFromJson(json);

  Map<String, dynamic> toJson() => _$PointModelToJson(this);
}


// *.g.dart 파일 생성 명령어
// flutter pub run build_runner build --delete-conflicting-outputs 