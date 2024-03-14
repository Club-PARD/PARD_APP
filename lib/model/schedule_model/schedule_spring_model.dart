class SpringScheduleModel{
  final String? title;
  final DateTime? schedule;
  final String? content;
  final String? part;

  SpringScheduleModel({required this.title, required this.schedule, required this.content, required this.part});

  factory SpringScheduleModel.fromJson(Map<String, dynamic> json) {
    return SpringScheduleModel(
      title: json['title'],
      schedule: json['schedule'],
      content: json['content'],
      part: json['part'],
    );
  }
  Map<String, dynamic> toJson() => {
    'title': title,
    'schedule': schedule,
    'content': content,
    'part': part,
  };
}