import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';
  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('not null DB');
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print('Creating a new one DB!');
          return db.execute(
            'CREATE TABLE $_tableName ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title STRING, note TEXT, date STRING, '
            'startTime STRING, endTime STRING, '
            'remind INTEGER , repeat STRING, '
            'color INTEGER, '
            'isCompleted INTEGER)',
          );
        },
      );
    } catch (e) {
      debugPrint('not null DB');
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print('Insert  function called !');
    print('We are here in insert DB');
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<int> delete(Task task) async {
    print('Delete function called !!');
    return await _db!.delete(_tableName, where: 'id =?', whereArgs: [task.id]);
  }

  static Future<int> deleteAllTasks() async {
    print('Delete All function called !!');
    return await _db!.delete(_tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('Query function called !!');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    print(' Update function called !');
    return await _db!.rawUpdate('''
UPDATE tasks
SET isCompleted = ? 
WHERE id = ?

''', [1, id]);
  }
}
