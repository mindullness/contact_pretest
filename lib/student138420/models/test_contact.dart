import './test_enum.dart';

class TestContact {
  int? id;
  late String name;
  late String phone;
  late String email;
  late int isFavorite;
  TestContact(this.name, this.phone, this.email, this.isFavorite);

  // factory TestContact.fromMap(Map<String, dynamic> map) {
  //   return TestContact(
  //     map[TestEnum.id],
  //     map[TestEnum.name],
  //     map[TestEnum.phone],
  //   );
  // }
  TestContact.fromMap(Map<String, dynamic> map) {
    id = map[TestEnum.id];
    name = map[TestEnum.name];
    phone = map[TestEnum.phone];
    email = map[TestEnum.email];
    isFavorite = map[TestEnum.isFavorite];
  }
  Map<String, dynamic> toMap() {
    return {
      TestEnum.id: id,
      TestEnum.name: name,
      TestEnum.phone: phone,
      TestEnum.email: email,
      TestEnum.isFavorite: isFavorite
    };
  }
}
