class UserPoint {
  final String email;
  final double totalBonus;
  final double totalMinus;
  final int partRanking;
  final int totalRanking;

  UserPoint({
    required this.email,
    required this.totalBonus,
    required this.totalMinus,
    required this.partRanking,
    required this.totalRanking,
  });

  factory UserPoint.fromJson(Map<String, dynamic> json) {
    return UserPoint(
      email: json['email'],
      totalBonus: json['totalBonus'].toDouble(),
      totalMinus: json['totalMinus'].toDouble(),
      partRanking: json['partRanking'],
      totalRanking: json['totalRanking'],
    );
  }
}
