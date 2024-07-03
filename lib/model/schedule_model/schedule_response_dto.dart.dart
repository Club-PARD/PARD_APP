class ScheduleResponseDTO {
  final String title;
  final String content;
  final String part;
  final DateTime date;
  final String contentsLocation;
  final bool notice;
  final int? remaingDay;
  final bool isPastEvent;

  ScheduleResponseDTO({
    required this.title,
    required this.content,
    required this.part,
    required this.date,
    required this.contentsLocation,
    required this.notice,
    this.remaingDay,
    required this.isPastEvent,
  });

  factory ScheduleResponseDTO.fromJson(Map<String, dynamic> json) {
    return ScheduleResponseDTO(
      title: json['title'],
      content: json['content'],
      part: json['part'],
      date: DateTime.parse(json['date']),
      contentsLocation: json['contentsLocation'],
      notice: json['notice'],
      remaingDay: json['remaingDay'],
      isPastEvent: json['isPastEvent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'part': part,
      'date': date.toIso8601String(),
      'contentsLocation': contentsLocation,
      'notice': notice,
      'remaingDay': remaingDay,
      'isPastEvent': isPastEvent,
    };
  }
}
