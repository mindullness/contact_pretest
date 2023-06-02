import 'package:pretest_prj/ver3/db/db.dart';
import 'package:pretest_prj/ver3/models/v3_contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactService {
  /// CRUD
  ///
  static Future<List<V3Contact>?> getContacts() async {
    try {
      final dB = await DB().db;
      final result = await dB.query(V3Enum.tblName);
      dB.close();
      return result.map((e) => V3Contact.fromMap(e)).toList();
    } catch (e) {
      return List.empty();
    }
  }

  static Future<bool> insert(V3Contact contact) async {
    try {
      final dB = await DB().db;
      final result = await dB.insert(
        V3Enum.tblName,
        contact.toMap(contact),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return result > 0 ? true : false;
    } catch (e) {
      return false;
    }
  }
}
