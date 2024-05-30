import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'errors/db_helper_error.dart';

class DBHelper {

  static const todoTable = 'task';
  static String? value = "pending";

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    try{
      return await openDatabase(
        join(dbPath, 'taskseek.db'),
        onCreate: (db, version) {
          db.execute("CREATE TABLE IF NOT EXISTS $todoTable(id TEXT PRIMARY KEY ,"
              " title TEXT,"
              " description TEXT,"
              " state TEXT)");
        },
        version: 1,
      );
    }catch(e){
      throw DbHelperError();
    }

  }


   static Future<List<Map<String, dynamic>>> selectAll(String value) async {
    final db = await DBHelper.database();

    try{
       return db.rawQuery('SELECT * FROM $todoTable WHERE state=?', [value]);
    }catch(e){
      throw DbHelperError();

    }

  }

  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    try{
      return db.insert(
        todoTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }catch(e){
      throw DbHelperError();
    }
  }

  static Future update(
      String tableName,
      String columnName,
      String value,
      String id,
      ) async {
    final db = await DBHelper.database();

    try{
      return db.update(
        todoTable,
        {columnName: value},
        where: 'id = ? ',
        whereArgs: [id],
      );
    }catch(e){
      throw DbHelperError();
    }

  }

  static Future deleteById(
      String tableName,
      String columnName,
      String id,
      ) async {
    final db = await DBHelper.database();

    try{
      return db.delete(
        todoTable,
        where: '$columnName = ?',
        whereArgs: [id],
      );
    }catch(e){
      throw DbHelperError();
    }

  }

  static Future deleteTable(String tableName) async {
    final db = await DBHelper.database();

    try{
      return db.rawQuery('DELETE FROM $todoTable');
    }catch(e){
      throw DbHelperError();
    }

  }
}

