class RankPointModel {
  final String name;
  final String part;

  RankPointModel({
    required this.name,
    required this.part,
  });

  factory RankPointModel.fromJson(Map<String, dynamic> json) {
    return RankPointModel(
      name: json['name'],
      part: json['part'],
    );
  }
}
