class AttendanceAdminRequestDTO {
  final String status;
  final String seminar;
  final String email;

  AttendanceAdminRequestDTO({
    required this.status,
    required this.seminar,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'seminar': seminar,
      'email': email,
    };
  }
}