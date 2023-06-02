import 'package:flutter/material.dart';
import 'package:pretest_prj/ver3/db/contact_service.dart';
import 'package:pretest_prj/ver3/models/v3_contact.dart';
import 'package:pretest_prj/ver3/pages/manage_contact.dart';

class AllContacts extends StatefulWidget {
  const AllContacts({super.key});

  @override
  State<AllContacts> createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  final TextEditingController _searchCtrler = TextEditingController();
  List<V3Contact> _contacts = [];
  List<V3Contact> _temp = [];
  @override
  void initState() {
    _refreshData();
    super.initState();
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.indigo)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageContact(
                                  isNew: true,
                                  contact: V3Contact(0, '', ''),
                                )));
                  },
                  child: const Icon(Icons.add, size: 18)),
            )
          ],
        ),
        body: Column(children: [
          SizedBox(
              child: TextField(
            onEditingComplete: _search,
            // onSubmitted: _search,
            controller: _searchCtrler,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
          )),
          _temp.isEmpty
              ? const SizedBox(
                  height: 200,
                  child: Center(child: Text('No contact found!')),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: _temp.length,
                      itemBuilder: (context, index) {
                        V3Contact e = _temp[index];
                        return Dismissible(
                            key: ValueKey(e.id.toString()),
                            child: Card(
                              shadowColor:
                                  const Color.fromARGB(162, 204, 34, 204),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 18),
                                child: Row(children: [
                                  Text(e.name),
                                  const Spacer(),
                                  Text(e.phone),
                                ]),
                              ),
                            ));
                      }),
                  // child: ListView(
                  //   children: _contacts
                  //       .map((e) => Dismissible(
                  //           key: ValueKey(e.id.toString()),
                  //           child: Card(
                  //             child: Row(
                  //               children: [
                  //                 Text(e.name),
                  //                 const Spacer(),
                  //                 Text(e.phone),
                  //               ],
                  //             ),
                  //           )))
                  //       .toList(),
                  // ),
                ),
        ]),
      ),
    );
  }

  Future<void> _refreshData() async {
    await ContactService.getContacts()
        .then((value) => _contacts = _temp = value ?? List.empty());
    setState(() {});
  }

  void _search() {
    String text = _searchCtrler.text;
    _temp = _contacts
        .where((e) => e.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    setState(() {});
  }
}
