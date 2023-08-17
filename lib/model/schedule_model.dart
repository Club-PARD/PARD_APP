class ScheduleModel {
  Map<String, int> attend;
  String title;
  String description;
  DateTime dueDate;
  String place;
  String part;
  bool previous;

  ScheduleModel(
    this.attend,
    this.title,
    this.description,
    this.dueDate,
    this.place,
    this.part,
    this.previous,
  );
}
