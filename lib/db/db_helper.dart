import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/task_model.dart';
class SqliteService {
  static Database? _database;
  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_todolist_sqflite");
    var database = await openDatabase(path,version: 1,onCreate: _onCreatingDatabase );
    return database;
  }
  _onCreatingDatabase(Database database, int version) async{
    await database.execute(
        "CREATE TABLE Tasks(id INTEGER PRIMARY KEY, category INTEGER, task_title TEXT,"
            "task_description TEXT, task_date TEXT, start_time TEXT, end_time TEXT)");
  }
  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await setDatabase();
    return _database;
  }
  insertData(TaskModel taskModel) async{
    var connection = await database;
    return await connection?.insert("Tasks", taskModel.toMap());
  }

  Future<Future<List<Map<String, Object?>>>> readData()  async{
    var connection = await database;
    return  connection!.query("Tasks");
  }

  Future<List<TaskModel>> getIslamTasks() async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 0");
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    return modelList;
  }
  Future<List<TaskModel>> getFamilyTasks() async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 1");
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    return modelList;
  }
  Future<List<TaskModel>> getWorkTasks() async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 2");
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    return modelList;
  }
  Future<List<TaskModel>> getPersonalTasks() async{
    Database? db = await database;
    var model = await db?.rawQuery(
        "SELECT * from Tasks where category = 3");
    List<TaskModel>? modelList =
    model!.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    return modelList;
  }
}

  /*Future<Database> initializeDB() async {
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
  }*/

  /*Future<int?> insertItem(TaskModel task) async {
    int result = 0;
    final Database db = await initializeDB();
    final id = await db.insert(
        'Tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }*/
 /* Future<List<TaskModel>> getItems() async {
    final db = await SqliteService.instance.database;
    var model = await db.rawQuery(
        "SELECT * from Tasks");
    List<TaskModel> modelList =
    model.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    return modelList;
  }*/

