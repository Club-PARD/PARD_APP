class RankingResponseDTO {
  final String name;
  final String part;
  final int totalBonus;

  RankingResponseDTO({
    required this.name,
    required this.part,
    required this.totalBonus,
  });

  factory RankingResponseDTO.fromJson(Map<String, dynamic> json) {
    return RankingResponseDTO(
      name: json['name'],
      part: json['part'],
      totalBonus: json['totalBonus'],
    );
  }
}
