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
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          await db.execute('''CREATE TABLE ${V4Enum.tblUser} (
            ${V4Enum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${V4Enum.username} VARCHAR(50) NOT NULL,
            ${V4Enum.password} VARCHAR(20)
          )''');
        }
      },
    );
  }

  FutureOr<dynamic> _createDb(Database db, int version) async {
    // Batch batch = db.batch();
    // DROP TABLE IF EXISTS ${V4Enum.tblContact}
    await db.execute('''
      CREATE TABLE ${V4Enum.tblContact} (
      ${V4Enum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${V4Enum.name} VARCHAR(50) NOT NULL,
      ${V4Enum.phone} VARCHAR(20)
    )''');
    // DROP TABLE IF EXISTS ${V4Enum.tblUser}
    return await db.execute('''
      CREATE TABLE ${V4Enum.tblUser} (
      ${V4Enum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${V4Enum.username} VARCHAR(50) NOT NULL,
      ${V4Enum.password} VARCHAR(20)
    )''');
    // List<dynamic> res = await batch.commit();
    // return res;
  }

  Future<void> close() async {
    final dB = await db;
    dB.close();
  }

  FutureOr<void> _upgradeDb(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();
    batch.execute('''CREATE TABLE ${V4Enum.tblContact} (
      ${V4Enum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${V4Enum.name} VARCHAR(50) NOT NULL,
      ${V4Enum.phone} VARCHAR(20)
    )''');
    batch.execute('''CREATE TABLE ${V4Enum.tblUser} (
      ${V4Enum.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${V4Enum.username} VARCHAR(50) NOT NULL,
      ${V4Enum.password} VARCHAR(20)
    )''');
    List<dynamic> res = await batch.commit();
  }
}
