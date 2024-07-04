class QRAttendanceRequestDTO {
  final String QRUrl;
  final String seminar;
  final DateTime time;

  QRAttendanceRequestDTO({
    required this.QRUrl,
    required this.seminar,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'QRUrl': QRUrl,
      'seminar': seminar,
      'time': time.toIso8601String(),
    };
  }
}
