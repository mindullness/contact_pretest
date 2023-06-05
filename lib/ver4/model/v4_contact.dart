class V4Contact {
  int? id;
  late String name;
  late String phone;

  V4Contact(this.name, this.phone);

  // factory V4Contact.fromMap(Map<String, dynamic> map) {
  //   return V4Contact(
  //     map[V4Enum.id],
  //     map[V4Enum.name],
  //     map[V4Enum.phone],
  //   );
  // }
  V4Contact.fromMap(Map<String, dynamic> map) {
    id = map[V4Enum.id];
    name = map[V4Enum.name];
    phone = map[V4Enum.phone];
  }
  Map<String, dynamic> toMap() {
    return {
      V4Enum.id: id,
      V4Enum.name: name,
      V4Enum.phone: phone,
    };
  }
}

class V4Enum {
  static const String dbName = 'V4ContactDb';
  static const String tblContact = 'Contact';
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';

  static const String tblUser = 'tblUser';
  static const String username = 'username';
  static const String password = 'password';
}
