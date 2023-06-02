import 'package:flutter/material.dart';
import 'package:pretest_prj/ver2/components/contact_item.dart';
import 'package:pretest_prj/ver2/repository/contact_repository.dart';
import 'package:pretest_prj/ver2/models/contact.dart';
import 'package:pretest_prj/ver2/pages/add_contact_activity.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  final TextEditingController _searchCtrler = TextEditingController();
  ContactRepository contactRepository = ContactRepository();

  String searchText = '';
  List<Contact> _contacts = [];
  List<Contact> _temp = [];
  @override
  void initState() {
    _refreshContacts();
    _searchCtrler.text = searchText;
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Contacts'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigator.of(context).pop(true);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ContactActivities(true, Contact(0, '', '')),
                  ),
                );
              },
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              child: TextField(
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.search)),
                controller: _searchCtrler,
                onEditingComplete: () {
                  setState(() {
                    searchText = _searchCtrler.text;
                    _temp = _contacts
                        .where((item) => item.name
                            .toLowerCase()
                            .contains(searchText.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView(
                  children: _temp.isEmpty
                      ? [
                          const Padding(
                            padding: EdgeInsets.all(30),
                            child: Center(child: Text('No contact found')),
                          )
                        ]
                      : _temp
                          .map(
                            (item) => Dismissible(
                              key: UniqueKey(),
                              child: ContactItem(item),
                              confirmDismiss: (direction) async {
                                bool isUpdate =
                                    direction == DismissDirection.startToEnd;
                                return confirmDialog(context, isUpdate);
                              },
                              onDismissed: (direction) async {
                                bool isUpdate =
                                    direction == DismissDirection.startToEnd;
                              },
                            ),
                          )
                          .toList()),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> confirmDialog(BuildContext context, bool isUpdate) {
    return showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text('Confirm'),
                                          content: Text(
                                              'Are you sure want to ${isUpdate ? 'update' : 'delete'} this contact?'),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: Text(isUpdate
                                                    ? 'UPDATE'
                                                    : 'DELETE')),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text('CANCEL'))
                                          ]));
  }

  Future<void> _refreshContacts() async {
    await contactRepository
        .getContacts()
        .then((result) => _contacts = _temp = result);
    setState(() {});
  }
}
