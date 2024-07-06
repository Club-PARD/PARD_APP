class AttendanceAdminRequestDTO {
  final String status;
  final String seminar;

  AttendanceAdminRequestDTO({
    required this.status,
    required this.seminar,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'seminar': seminar,
    };
  }
}