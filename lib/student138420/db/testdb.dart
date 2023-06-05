import 'dart:async';

import 'package:pretest_prj/student138420/models/test_enum.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TestDB {
  Database? _database;

  static final TestDB _instance = TestDB._internal();
  TestDB._internal();

  factory TestDB() {
    return _instance;
  }

  Future<Database> get db async {
    return _database ?? await _initDb(TestEnum.dbName);
  }

  Future<Database> _initDb(String filePath) async {
    var context = Context(style: Style.platform);

    final dbPath = await getDatabasesPath();
    final path = context.join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  FutureOr<dynamic> _createDb(Database db, int version) async {
    // DROP TABLE IF EXISTS ${TestEnum.tblName}
    return await db.execute('''
            CREATE TABLE ${TestEnum.tblName} (
            ${TestEnum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${TestEnum.name} VARCHAR(50) NOT NULL,
            ${TestEnum.phone} VARCHAR(20),
            ${TestEnum.email} VARCHAR(30),
            ${TestEnum.isFavorite} INTEGER
          )''');
  }

  Future<void> close() async {
    final dB = await db;
    dB.close();
  }

  // FutureOr<void> _upgradeDb(Database db, int oldVersion, int newVersion) async {
  //   Batch batch = db.batch();
  //   batch.execute('''CREATE TABLE ${TestEnum.tblName} (
  //     ${TestEnum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  //     ${TestEnum.name} VARCHAR(50) NOT NULL,
  //     ${TestEnum.phone} VARCHAR(20)
  //   )''');
  //   batch.execute('''CREATE TABLE ${TestEnum.tblName} (
  //     ${TestEnum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  //     ${TestEnum.name} VARCHAR(50) NOT NULL,
  //     ${TestEnum.phone} VARCHAR(20)
  //   )''');
  //   List<dynamic> res = await batch.commit();
  // }
}
