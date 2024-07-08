class QRAttendanceRequestDTO {
  final String qrUrl;
  final String seminar;

  QRAttendanceRequestDTO({
    required this.qrUrl,
    required this.seminar,
  });

  factory QRAttendanceRequestDTO.fromJson(Map<String, dynamic> json) {
    return QRAttendanceRequestDTO(
      qrUrl: json['qrUrl'] as String,
      seminar: json['seminar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qrUrl': qrUrl,
      'seminar': seminar,
    };
  }
}
