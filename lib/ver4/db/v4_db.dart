import 'dart:async';

import 'package:pretest_prj/ver4/model/v4_contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  Database? _database;

  static final DB _instance = DB._internal();
  DB._internal();
  
  factory DB() {
    return _instance;
  }

  Future<Database> get db async {
    return _database ?? await _initDb(V4Enum.dbName);
  }

  Future<Database> _initDb(String filePath) async {
    var context = Context(style: Style.platform);

    final dbPath = await getDatabasesPath();
    final path = context.join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  FutureOr<void> _createDb(Database db, int version) async {
    return await db.execute('''CREATE TABLE ${V4Enum.tblName} (
      ${V4Enum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${V4Enum.name} VARCHAR(50) NOT NULL,
      ${V4Enum.phone} VARCHAR(20)
    )''');
  }

  Future<void> close() async {
    final dB = await db;
    dB.close();
  }
}
