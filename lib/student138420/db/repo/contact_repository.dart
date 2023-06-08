import 'package:pretest_prj/student138420/db/testdb.dart';
import 'package:pretest_prj/student138420/models/test_contact.dart';
import 'package:pretest_prj/student138420/models/test_enum.dart';

class TetsRepository {
  static Future<List<TestContact>> getContacts() async {
    final dB = await TestDB().db;
    // await dB.execute('''DROP TABLE IF EXISTS ${TestEnum.tblName}''');
    final result = await dB.query(
      TestEnum.tblName,
      orderBy: TestEnum.name,
    );
    return result.map((item) => TestContact.fromMap(item)).toList();
  }

  static Future<List<TestContact>> getFavs() async {
    final dB = await TestDB().db;
    final result = await dB.query(
      TestEnum.tblName,
      where: '${TestEnum.isFavorite} = ?',
      whereArgs: [2],
      orderBy: TestEnum.name,
    );
    return result.map((item) => TestContact.fromMap(item)).toList();
  }

  static Future<bool> insert(TestContact contact) async {
    var result = 0;
    final dB = await TestDB().db;
    try {
      result = await dB.insert(
        TestEnum.tblName,
        contact.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
    dB.close();

    return result > 0 ? true : false;
  }

  static Future<bool> update(TestContact contact) async {
    var result = 0;
    final dB = await TestDB().db;
    try {
      result = await dB.update(
        TestEnum.tblName,
        contact.toMap(),
        where: '${TestEnum.id} = ?',
        whereArgs: [contact.id],
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
    dB.close();

    return result > 0 ? true : false;
  }
}
