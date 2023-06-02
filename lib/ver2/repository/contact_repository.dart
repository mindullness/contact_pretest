import 'package:pretest_prj/ver2/enum/enums.dart';
import 'package:pretest_prj/ver2/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../../ver2/db/db.dart';

class ContactRepository {
  Future<List<Contact>> getContacts() async {
    final dB = await DB().db;
    final result = await dB.query(EnumContact.tblContact);
    dB.close();
    return result.map((e) => Contact.fromMap(e)).toList();
  }

  Future<bool> insert(Contact contact) async {
    var result = 0;
    final dB = await DB().db;
    try {
      result = await dB.insert(
        EnumContact.tblContact,
        contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
    dB.close();

    return result > 0 ? true : false;
  }

  Future<bool> update(Contact contact) async {
    var result = 0;
    final dB = await DB().db;
    try {
      result = await dB.update(
        EnumContact.tblContact,
        contact.toMap(),
        where: '${EnumContact.id} = ?',
        whereArgs: [contact.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
    dB.close();

    return result > 0 ? true : false;
  }

  Future<bool> delete(int id) async {
    final dB = await DB().db;
    final result = await dB.delete(
      EnumContact.tblContact,
      where: '${EnumContact.id} = ?',
      whereArgs: [id],
    );
    dB.close();
    return result > 0 ? true : false;
  }
}
