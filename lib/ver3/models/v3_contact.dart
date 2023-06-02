class V3Contact {
  int id;
  late String name;
  late String phone;
  V3Contact(this.id, this.name, this.phone);

  factory V3Contact.fromMap(Map<String, dynamic> map) {
    return V3Contact(
      map[V3Enum.id],
      map[V3Enum.name],
      map[V3Enum.phone],
    );
  }
  Map<String, dynamic> toMap(V3Contact contact) {
    return {
      // V3Enum.id: id,
      V3Enum.name: name,
      V3Enum.phone: phone,
    };
  }
}

class V3Enum {
  static const String dbName = 'V3ContactDb';
  static const String tblName = 'Contact';
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
}
