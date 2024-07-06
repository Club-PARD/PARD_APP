class ReasonBonus {
  final int reasonId;
  final double point;
  final String reason;
  final bool isBonus;
  final String detail;
  final DateTime createAt;

  ReasonBonus({
    required this.reasonId,
    required this.point,
    required this.reason,
    required this.isBonus,
    required this.detail,
    required this.createAt,
  });

  factory ReasonBonus.fromJson(Map<String, dynamic> json) {
    return ReasonBonus(
      reasonId: json['reasonId'] ?? 0,
      point: (json['point'] ?? 0.0).toDouble(),
      reason: json['reason'] ?? '',
      isBonus: json['bonus'] ?? true,
      detail: json['detail'] ?? '',
      createAt: DateTime.tryParse(json['createAt'] ?? '') ?? DateTime.now(),
    );
  }
}
