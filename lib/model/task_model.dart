class TaskModel {
  final int? id;
  final int? category;
  final String? task_title;
  final String? task_description;
  final String? date;
  final String? start_time;
  final String? end_time;

  TaskModel(
      {this.id,
        this.category,
        this.task_title,
        this.task_description,
        this.date,
        this.start_time,
        this.end_time});

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    category: json['category'],
    task_title: json['task_title'],
    task_description: json['task_description'],
    date: json['date'],
    start_time: json['start_time'],
    end_time: json["end_time"],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'task_title': task_title,
      'task_description': task_description,
      'date': date,
      'start_time': start_time,
      "end_time": end_time
    };
  }
}
