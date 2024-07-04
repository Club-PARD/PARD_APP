class AttendanceResponse {
  final bool isAttended;

  AttendanceResponse({required this.isAttended});

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      isAttended: json['isAttended'],
    );
  }
}
