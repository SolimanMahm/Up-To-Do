class TaskModel {
  final String title, note, startTime, endTime, date;
  final int color, isComoleted;
  final int? id;

  TaskModel({
    this.id,
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.isComoleted,
    required this.color,
  });

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData['id'],
      title: jsonData['title'],
      note: jsonData['notes'],
      startTime: jsonData['startTime'],
      endTime: jsonData['endTime'],
      date: jsonData['date'],
      isComoleted: jsonData['isCompleted'],
      color: jsonData['color'],
    );
  }
}
