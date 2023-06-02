import 'dart:async';

import 'package:pretest_prj/ver3/models/v3_contact.dart';
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
    return _database ?? await _initDb(V3Enum.dbName);
  }

  Future<Database> _initDb(String filePath) async {
    var context = Context(style: Style.platform);

    final dbPath = await getDatabasesPath();
    final path = context.join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  FutureOr<void> _createDb(Database db, int version) async {
    return await db.execute('''CREATE TABLE ${V3Enum.tblName} (
      ${V3Enum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${V3Enum.name} VARCHAR(50) NOT NULL,
      ${V3Enum.phone} VARCHAR(20)
    )''');
  }

  Future<void> close() async {
    final dB = await db;
    dB.close();
  }
}
