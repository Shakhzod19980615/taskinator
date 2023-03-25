import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/task_model.dart';
class SqliteService {


  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE Tasks(id INTEGER PRIMARY KEY, category INTEGER, task_title TEXT,"
                "task_description TEXT, task_date TEXT, start_time TEXT, end_time TEXT)");

      },
      version: 1,
    );
  }

  Future<int?> insertItem(TaskModel task) async {
    int result = 0;
    final Database db = await initializeDB();
    final id = await db.insert(
        'Tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }
 /* Future<List<TaskModel>> getItems() async {
    final db = await SqliteService.instance.database;
    var model = await db.rawQuery(
        "SELECT * from Tasks");
    List<TaskModel> modelList =
    model.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    return modelList;
  }*/
}
