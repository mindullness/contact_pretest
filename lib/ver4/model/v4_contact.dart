class V4Contact{
  int id;
  String name;
  String phone;

  V4Contact(this.id, this.name, this.phone);

  factory V4Contact.fromMap(Map<String, dynamic> map) {
    return V4Contact(
      map[V4Enum.id],
      map[V4Enum.name],
      map[V4Enum.phone],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      // V4Enum.id: id,
      V4Enum.name: name,
      V4Enum.phone: phone,
    };
  }
}
class V4Enum{
  static const String dbName = 'V4ContactDb';
  static const String tblName = 'Contact';
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
}