import 'package:pretest_prj/ver2/enum/enums.dart';

class Contact {
  int id;
  String name;
  String phone;

  Contact(this.id, this.name, this.phone);

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      map[EnumContact.id],
      map[EnumContact.name],
      map[EnumContact.phone],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      // EnumContact.id: id,
      EnumContact.name: name,
      EnumContact.phone: phone,
    };
  }
}
