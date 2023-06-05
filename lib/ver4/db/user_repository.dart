import 'package:pretest_prj/ver4/db/v4_db.dart';
import 'package:pretest_prj/ver4/model/user.dart';
import 'package:pretest_prj/ver4/model/v4_contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

class UserRepository {
  static final _key = Key.fromUtf8('doembietanhxaikeygisaomabietduoc');
  static final _iv = IV.fromLength(16);
  // static final _b64key = Key.fromUtf8(base64Url.encode(_key.bytes));
  static final _encrypter = Encrypter(AES(_key));

  static Future<User?> login(User user) async {
    try {
      final passwordToCheck = _encrypter.encrypt(user.password, iv: _iv);
      ;
      final dB = await DB().db;
      final result = await dB.query(V4Enum.tblUser,
          where: '${V4Enum.username} = ? AND ${V4Enum.password} = ?',
          whereArgs: [user.username, passwordToCheck.base64],
          limit: 1);
      // return result.map((e) => User.fromMap(e)).first;
      final u = result.first;
      return User.fromMap(u);

      // var result = await dB.rawQuery(
      //     "SELECT * FROM ${V4Enum.tblUser} WHERE username = '${V4Enum.username}' and password = '${V4Enum.password}'");

      // if (result.length > 0) {
      //   return User.fromMap(result.first);
      // }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> signup(User user) async {
    var result = 0;
    final dB = await DB().db;
    try {
      final plainText = user.password;

      final encrypted = _encrypter.encrypt(plainText, iv: _iv);
      final decrypted = _encrypter.decrypt(encrypted, iv: _iv);

      user.password = encrypted.base64;

      result = await dB.insert(
        V4Enum.tblUser,
        user.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
    dB.close();

    return result > 0 ? true : false;
  }
}
