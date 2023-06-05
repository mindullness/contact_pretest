import 'package:pretest_prj/ver4/db/v4_db.dart';
import 'package:pretest_prj/ver4/model/v4_contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository {

  // static Future<List<V4Contact>> getContacts() async {
  //   final dB = await DB().db;
  //   final result = await dB.query(V4Enum.tblContact, orderBy: V4Enum.name);
  //   dB.close();
  //   return result.map((e) => V4Contact.fromMap(e)).toList();
  // }

  static Future<List<V4Contact>> getContacts(String text) async {
    final dB = await DB().db;
    final result = await dB.query(
      V4Enum.tblContact,
      where: '${V4Enum.name} LIKE ?',
      whereArgs: ['%$text%'],
      orderBy: V4Enum.name,
    );
    return result.map((item) => V4Contact.fromMap(item)).toList();
  }

  static Future<bool> insert(V4Contact contact) async {
    var result = 0;
    final dB = await DB().db;
    try {
      result = await dB.insert(
        V4Enum.tblContact,
        contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
    dB.close();

    return result > 0 ? true : false;
  }

  static Future<bool> update(V4Contact contact) async {
    var result = 0;
    final dB = await DB().db;
    try {
      result = await dB.update(
        V4Enum.tblContact,
        contact.toMap(),
        where: '${V4Enum.id} = ?',
        whereArgs: [contact.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
    dB.close();

    return result > 0 ? true : false;
  }

  static Future<bool> delete(int id) async {
    final dB = await DB().db;
    final result = await dB.delete(
      V4Enum.tblContact,
      where: '${V4Enum.id} = ?',
      whereArgs: [id],
    );
    dB.close();
    return result > 0 ? true : false;
  }
}
