import 'package:pretest_prj/ver4/model/v4_contact.dart';

class User {
  int? id;
  late String username;
  late String password;
  User(this.username, this.password);

  User.fromMap(Map<String, dynamic> map) {
    id = map[V4Enum.id];
    username = map[V4Enum.username];
    password = map[V4Enum.password];
  }
  Map<String, dynamic> toMap() {
    return {
      V4Enum.id: id,
      V4Enum.username: username,
      V4Enum.password: password
    };
  }
}
