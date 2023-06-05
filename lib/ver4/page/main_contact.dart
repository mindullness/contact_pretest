import 'package:flutter/material.dart';
import 'package:pretest_prj/ver4/components/drawer.dart';
import 'package:pretest_prj/ver4/db/contact_repository.dart';
import 'package:pretest_prj/ver4/components/v4_contact_item.dart';

import 'package:pretest_prj/ver4/model/v4_contact.dart';
import 'package:pretest_prj/ver4/page/login.dart';
import 'package:pretest_prj/ver4/page/manage_contact.dart';

class MainContact extends StatefulWidget {
  const MainContact({super.key});

  @override
  State<MainContact> createState() => _MainContactState();
}

class _MainContactState extends State<MainContact> {
  final TextEditingController _searchCtrler = TextEditingController();
  // List<V4Contact> _contacts = [];
  List<V4Contact> _temp = [];

  @override
  void initState() {
    _refreshContacts('');
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
        drawer: const DrawerMenu(),
        appBar: AppBar(
          title: const Text('All Contacts'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                        (states) => const RoundedRectangleBorder()),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.indigo)),
                child: const Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigator.of(context).pop(true);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          V4ManageContact(true, V4Contact('', '')),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                        (states) => const RoundedRectangleBorder()),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.indigo)),
                child: const Icon(
                  Icons.app_registration_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigator.of(context).pop(true);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Login(true),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(false),
                ),
              );
            },
            child: const Icon(Icons.login)),
        body: Column(
          children: [
            SizedBox(
              child: TextField(
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.search)),
                controller: _searchCtrler,
                onEditingComplete: () {
                  _refreshContacts(_searchCtrler.text);
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
                              background: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Theme.of(context)
                                        .cardTheme
                                        .margin!
                                        .horizontal),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.75),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(children: const [
                                    Icon(Icons.edit, color: Colors.white),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Update',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ]),
                                ),
                              ),
                              secondaryBackground: Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withOpacity(0.75),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(children: const [
                                    Spacer(),
                                    Icon(Icons.delete, color: Colors.pink),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text('Delete',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 60, 76, 85))),
                                  ]),
                                ),
                              ),
                              child: V4ContactItem(item),
                              confirmDismiss: (direction) async {
                                bool isUpdate =
                                    direction == DismissDirection.startToEnd;
                                return confirmDialog(context, isUpdate);
                              },
                              onDismissed: (direction) async {
                                bool isUpdate =
                                    direction == DismissDirection.startToEnd;
                                if (isUpdate) {
                                  // Navigator.of(context).pop(true);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            V4ManageContact(false, item),
                                      ));
                                } else {
                                  _deleteContact(item);
                                }
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
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(isUpdate ? 'UPDATE' : 'DELETE')),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('CANCEL'))
                ]));
  }

  Future<void> _refreshContacts(String searchText) async {
    await ContactRepository.getContacts(searchText)
        .then((result) => _temp = result);
    // .then((result) => _contacts = _temp = result);
    setState(() {});
  }

  // void _search() {
  //   String text = _searchCtrler.text;
  //   _temp = _contacts
  //       .where((e) => e.name.toLowerCase().contains(text.toLowerCase()))
  //       .toList();
  //   setState(() {});
  // }

  Future<void> _deleteContact(V4Contact contact) async {
    await ContactRepository.delete(contact.id!).then((value) => {
          if (value)
            {
              // _contacts.remove(contact),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(children: const [
                Icon(Icons.done, color: Colors.red),
                Text('Delete successfully!')
              ]))),
              _refreshContacts('')
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(children: const [
                Icon(Icons.error_outline, color: Colors.red),
                Text('Delete failed', style: TextStyle(color: Colors.amber))
              ])))
            }
        });
  }
}
