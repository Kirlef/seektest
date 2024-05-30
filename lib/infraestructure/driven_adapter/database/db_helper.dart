import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'errors/db_helper_error.dart';

/// DBHelper class to handle SQLite database operations.
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

  /// Selects all rows from the table where the state equals the provided value.
  ///
  /// [value] The state value to filter the rows by.
  /// Returns a list of maps containing the selected data.
   static Future<List<Map<String, dynamic>>> selectAll(String value) async {
    final db = await DBHelper.database();

    try{
       return db.rawQuery('SELECT * FROM $todoTable WHERE state=?', [value]);
    }catch(e){
      throw DbHelperError();

    }

  }

  /// Inserts a new row into the specified table.
  ///
  /// [table] The name of the table.
  /// [data] A map containing the data to insert.
  /// Returns the ID of the inserted row.
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

  /// Updates a specific row in the table.
  ///
  /// [tableName] The name of the table.
  /// [columnName] The name of the column to update.
  /// [value] The new value for the column.
  /// [id] The ID of the row to update.
  /// Returns the number of rows affected.
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

  /// Deletes a specific row from the table by its ID.
  ///
  /// [tableName] The name of the table.
  /// [columnName] The name of the column containing the ID.
  /// [id] The ID of the row to delete.
  /// Returns the number of rows deleted.
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

  /// Deletes all rows from the table.
  ///
  /// [tableName] The name of the table.
  /// Returns the number of rows deleted.
  static Future deleteTable(String tableName) async {
    final db = await DBHelper.database();

    try{
      return db.rawQuery('DELETE FROM $todoTable');
    }catch(e){
      throw DbHelperError();
    }

  }
}

