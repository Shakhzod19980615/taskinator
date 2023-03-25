/*
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskinatoruz/model/task_model.dart';



class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final task_table = 'task_table';

  static final id = "_id";
  static final category = "category";
  static final title = "title";
  static final task_description = "task_description";
  static final task_date = "task_date";
  static final start_time = "start_time";
  static final end_time = "end_time";

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $task_table (
            $id INTEGER PRIMARY KEY,
            $category TEXT NOT NULL,
            $title TEXT NOT NULL,
            $task_description TEXT,
            $task_date TEXT,
            $start_time TEXT,
            $end_time TEXT
          )
          ''');
  }
  */
/*_insert(TaskModel taskModel) async {

    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await DatabaseHelper.instance.database;

    // row to insert

    // do the insert and get the id of the inserted row
    int id = await db.insert(DatabaseHelper.task,taskModel as Map<String, Object?>);

    // show the results: print all rows in the db
    print(await db.query(DatabaseHelper.task));
  }*//*

Future<void> insertTask(TaskModel tasks) async{

    final Database db = await instance.database;
    await db.insert("task_table", tasks.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    */
/*String insertInfos = """INSERT INTO task(category, task_title, task_description, date, start_time,end_time)
    VALUES(${tasks.category},${tasks.task_title},${tasks.task_description},${tasks.date },
    ${tasks.start_time},${tasks.end_time} )""";
    await db.rawQuery(insertInfos);*//*


  }
Future<List<TaskModel>> getTasks() async{
    Database db = await instance.database;
    var model = await db.rawQuery(
        "SELECT * from task_table");
    List<TaskModel> modelList =
    model.isNotEmpty ? model.map((c) => TaskModel.fromMap(c)).toList():[];
    return modelList;
  }
}
*/
