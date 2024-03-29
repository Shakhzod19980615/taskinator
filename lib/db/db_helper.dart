import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task_model.dart';
class SqliteService {
  static Database? _database;
  static ValueNotifier onChange = ValueNotifier(0);

  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_todolist_sqflite");
    var database = await openDatabase(path,version: 1,onCreate: _onCreatingDatabase );
    return database;
  }
  _onCreatingDatabase(Database database, int version) async{
    await database.execute(
        "CREATE TABLE Tasks(id INTEGER PRIMARY KEY, category INTEGER, task_title TEXT,"
            "task_description TEXT, task_date TEXT, start_time TEXT, end_time TEXT, isSaved INTEGER, isCompleted INTEGER)");
  }
  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await setDatabase();
    return _database;
  }
  insertData(TaskModel taskModel) async{
    var connection = await database;
    await connection?.insert("Tasks", taskModel.toMap());
    onChange.notifyListeners();
  }

  Future<Future<List<Map<String, Object?>>>> readData()  async{
    var connection = await database;
    return  connection!.query("Tasks");
  }

  Future<List<TaskModel>> getIslamTasks(String selectedDate) async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 0 AND task_date= ?",[selectedDate]);
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    onChange.notifyListeners();
    return modelList;
  }
  Future<List<TaskModel>> getFamilyTasks(String selectedDate) async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 1 AND task_date= ?",[selectedDate]);
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    onChange.notifyListeners();
    return modelList;
  }
  Future<List<TaskModel>> getWorkTasks(String selectedDate) async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 2 AND task_date= ?",[selectedDate]);
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    onChange.notifyListeners();
    return modelList;
  }
  Future<List<TaskModel>> getPersonalTasks(String selectedDate) async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 3 AND task_date= ?",[selectedDate]);
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    onChange.notifyListeners();
    return modelList;
  }

  Future<List<TaskModel>> getSavedTasks() async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where isSaved = 1 "
    );
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    onChange.notifyListeners();
    return modelList;
  }
  Future<TaskModel> getTaskById(int? id) async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where id = $id");
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    onChange.notifyListeners();
    return modelList.first;
  }
  Future<List<TaskModel>> deleteTask(int? id,) async{
    Database? db = await database;

    var model = await db?.rawQuery(
        "DELETE FROM Tasks WHERE  id = $id ");
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    onChange.notifyListeners();
    return modelList;
  }
  Future<Future<int>?> updateTasks(TaskModel taskModel)async{
    print("inserting id ${taskModel.id}");
    Database? db = await database;
    var result = db?.rawUpdate("UPDATE Tasks SET task_title=?, task_description=?, start_time=?,end_time=?,isCompleted=?"
        " WHERE id=${taskModel.id}",[taskModel.task_title,taskModel.task_description,
      taskModel.start_time,taskModel.end_time,taskModel.isCompleted]);
    onChange.notifyListeners();
    return result;
  }

}

