class TaskModel {
  final int? id;
  final int? category;
  final String? task_title;
  final String? task_description;
  final String? task_date;
  final String? start_time;
  final String? end_time;
  final int? isSaved;

  TaskModel(
      {this.id,
        this.category,
        this.task_title,
        this.task_description,
        this.task_date,
        this.start_time,
        this.end_time,
        this.isSaved});

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    category: json['category'],
    task_title: json['task_title'],
    task_description: json['task_description'],
    task_date: json['task_date'],
    start_time: json['start_time'],
    end_time: json["end_time"],
    isSaved: json["isSaved"]
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'task_title': task_title,
      'task_description': task_description,
      'task_date': task_date,
      'start_time': start_time,
      "end_time": end_time,
      "isSaved":isSaved,
    };
  }
}
