import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mytodo_app/models/todoModel.dart';

final String tableName = 'TodoList';

class DBHelper {

  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'TodoList.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE $tableName(id INTEGER PRIMARY KEY, work TEXT, deadline Text)");
      },  
      onUpgrade: (db, oldVersion, newVersion) {}
    );
  }
  
  //Insert
  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      'TodoList',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Read All
  Future<List<Todo>> getAllTodo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('TodoList');
    return List.generate(maps.length, (index) {
      return Todo(
        id: maps[index]['id'],
        work: maps[index]['work'],
        deadline: maps[index]['deadline'],
      );
    });
  }

  //Update
  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'TodoList',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  //Delete
  Future<void> deleteTodo(id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Delete All
  Future<void> deleteAllTodo() async {
    final db = await database;
    await db.rawDelete('DELETE FROM $tableName');
  }
}