class RankPointModel {
  final String name;
  final String part;
  final double totalBonus;

  RankPointModel({
    required this.name,
    required this.part,
    required this.totalBonus,
  });

  factory RankPointModel.fromJson(Map<String, dynamic> json) {
    return RankPointModel(
      name: json['name'],
      part: json['part'],
      totalBonus: json['totalBonus'].toDouble(),
    );
  }
}
