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
    print('[DBHelper] initDB: Success');
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
        pageBuilder: (_,__,___) => MyApp(),
      ));
    });

  }
}
