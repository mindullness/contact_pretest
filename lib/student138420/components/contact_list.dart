import 'package:flutter/material.dart';
import 'package:pretest_prj/student138420/models/test_contact.dart';
import 'package:pretest_prj/student138420/components/contact_item.dart';

class ContactList extends StatelessWidget {
  const ContactList(this._contacts, {super.key, required});
  final List<TestContact> _contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: ((context, index) => Dismissible(
            key: ValueKey(_contacts[index]),
            child: ContactItem(_contacts[index]))));
  }
}
