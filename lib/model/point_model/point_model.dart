import 'package:json_annotation/json_annotation.dart';

/// This allows the `PointModel` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'point_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class PointModel {
  PointModel(this.uid, this.pid, this.points, this.beePoints);

  String? uid;
  String? pid;
  List<Map>? points;
  List<Map>? beePoints;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$PointModelFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory PointModel.fromJson(Map<String, dynamic> json) =>
      _$PointModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PointModelToJson`.
  Map<String, dynamic> toJson() => _$PointModelToJson(this);
}

// *.g.dart 파일 생성 명령어
// flutter pub run build_runner build --delete-conflicting-outputs 