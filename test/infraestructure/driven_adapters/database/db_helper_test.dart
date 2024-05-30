import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:seektest/infraestructure/driven_adapter/database/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });


  group('DBHelper Tests', () {
    setUp(() async {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'taskseek.db');

      await deleteDatabase(path);
    });

    test('Database creation', () async {
      final db = await DBHelper.database();

      final tables = await db.rawQuery(
          'SELECT name FROM sqlite_master WHERE type = "table" AND name = "${DBHelper.todoTable}"');

      expect(tables.length, 1);
    });

    test('Insert and select all tasks', () async {
      final db = await DBHelper.database();

      await DBHelper.insert(DBHelper.todoTable, {
        'id': '1',
        'title': 'Test Task',
        'description': 'Description of Test Task',
        'state': 'pending'
      });

      final tasks = await DBHelper.selectAll("pending");

      expect(tasks.length, 1);
      expect(tasks.first['title'], 'Test Task');
    });

    test('Update a task', () async {
      final db = await DBHelper.database();

      await DBHelper.insert(DBHelper.todoTable, {
        'id': '1',
        'title': 'Test Task',
        'description': 'Description of Test Task',
        'state': 'pending'
      });

      await DBHelper.update(DBHelper.todoTable, 'title', 'Updated Task', '1');

      final tasks = await DBHelper.selectAll("pending");
      expect(tasks.first['title'], 'Updated Task');
    });

    test('Delete a task by ID', () async {
      final db = await DBHelper.database();

      await DBHelper.insert(DBHelper.todoTable, {
        'id': '1',
        'title': 'Test Task',
        'description': 'Description of Test Task',
        'state': 'pending'
      });

      await DBHelper.deleteById(DBHelper.todoTable, 'id', '1');

      final tasks = await DBHelper.selectAll("pending");
      expect(tasks.length, 0);
    });

    test('Delete all tasks from table', () async {
      final db = await DBHelper.database();

      await DBHelper.insert(DBHelper.todoTable, {
        'id': '1',
        'title': 'Test Task',
        'description': 'Description of Test Task',
        'state': 'pending'
      });

      await DBHelper.insert(DBHelper.todoTable, {
        'id': '2',
        'title': 'Another Task',
        'description': 'Description of Another Task',
        'state': 'pending'
      });

      await DBHelper.deleteTable(DBHelper.todoTable);

      final tasks = await DBHelper.selectAll("pending");
      expect(tasks.length, 0);
    });
  });
}
