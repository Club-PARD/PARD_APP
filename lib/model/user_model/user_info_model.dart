class UserInfo {
  final String part;
  final String name;
  final String role;
  final String generation;
  final double totalBonus;
  final double totalMinus;
  final double pangoolPoint;

  UserInfo({
    this.part = '',
    this.name = '',
    this.role = '',
    this.generation = '',
    this.totalBonus = 0.0,
    this.totalMinus = 0.0,
    this.pangoolPoint = 0.0,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      part: json['part'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      generation: json['generation'] ?? '',
      totalBonus: (json['totalBonus'] ?? 0).toDouble(),
      totalMinus: (json['totalMinus'] ?? 0).toDouble(),
      pangoolPoint: (json['pangoolPoint'] ?? 0).toDouble(),
    );
  }
}