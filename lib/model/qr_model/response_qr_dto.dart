class AttendanceResponse {
  final bool attended;

  AttendanceResponse({required this.attended});

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      attended: json['attended'],
    );
  }
}
