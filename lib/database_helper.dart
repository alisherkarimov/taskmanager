import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskmanager/models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  final String tableName = 'tableName';
  final String colId = 'id';
  final String colDescription = "description";
  final String colName = 'name';
  final String colStartTime = 'startTime';
  final String colEndTime = 'endTime';

  Future<Database?> get db async {
    return _db ?? await _initDB();
  }

  Future<Database?> _initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentDirectory.path}task.db';
    _db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      db.execute("Create table $tableName ($colId INTEGER PRIMARY KEY,"
          "$colName TEXT,"
          "$colDescription TEXT,"
          " $colStartTime TEXT,"
          "$colEndTime TEXT)");
    });
    return _db;
  }

  Future<Task> insert(Task task) async {
    final data = await db;
    task.id = await data?.insert(tableName, task.toMap());
    return task;
  }

  update(Task task) async {
    final data = await db;
    task.id = await data?.update(tableName, task.toMap(),
        where: "$colId = ?", whereArgs: [task.id]);
  }

  delete(Task task) async {
    final data = await db;
    task.id = await data
        ?.delete(tableName, where: "$colId = ?", whereArgs: [task.id]);
  }

  Future<List<Map<String, Object?>>?> getTaskMapList() async {
    final data = await db;
    final List<Map<String, Object?>>? result = await data?.query(tableName);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, Object?>>? taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList?.forEach((element) {
      taskList.add(Task.fromMap(element));
    });
    return taskList;
  }
}
