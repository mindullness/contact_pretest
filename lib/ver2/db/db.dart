import 'dart:async';
import 'package:pretest_prj/ver2/enum/enums.dart';
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
    return _database ?? await _initDb(EnumContact.dBContact);
  }

  Future<Database> _initDb(String filePath) async {
    var context = Context(style: Style.platform);

    final dbPath = await getDatabasesPath();
    final path = context.join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  FutureOr<void> _createDb(Database db, int version) async {
    return db.execute('''CREATE TABLE ${EnumContact.tblContact} (
      ${EnumContact.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${EnumContact.name} VARCHAR(50) NOT NULL,
      ${EnumContact.phone} VARCHAR(20)
    )''');
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
