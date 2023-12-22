import 'package:flutter/cupertino.dart';
import 'package:proyecto_flutter/main.dart';
import 'package:proyecto_flutter/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database?> initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'oamg.db');
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
    return db;
  }

  void _createTables(Database db, int version) async {
    await db.execute(
      'CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, name TEXT, lastname TEXT)',
    );
  }

  Future<void> insertUser(User user, BuildContext context) async {
    ///Obtiene una referencia a la base de datos.
    final Database db = await database;
    await db.insert(
      'User',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    ).then((int value) {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_,__,___) => const MyApp(),
      ));
    });
  }

  Future<List<User>?> getUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User');
    return List.generate(maps.length, (i) {
      return User(
          id: maps[i]['id'],
          name: maps[i]['name'],
          lastname: maps[i]['lastname'],
          email: maps[i]['email'],
      );
    });
  }

  Future<void> deleteUser(int id)async {
    final db = await database;
    await db.delete(
      'User',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'User',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
