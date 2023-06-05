import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pretest_prj/student138420/components/add_dialog.dart';
import 'package:pretest_prj/student138420/components/test_drawer.dart';
import 'package:pretest_prj/student138420/db/repo/contact_repository.dart';
import 'package:pretest_prj/student138420/models/test_contact.dart';
import 'package:pretest_prj/student138420/utils/snackbar_helper.dart';
import 'package:pretest_prj/student138420/components/contact_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
        text: 'All contacts',
        icon: Icon(
          Icons.done_all,
          color: Color.fromARGB(255, 247, 0, 0),
        )),
    Tab(text: 'Favorite', icon: Icon(Icons.favorite, color: Colors.pink)),
  ];

  final TextEditingController _nameCtrler = TextEditingController();
  final TextEditingController _phoneCtrler = TextEditingController();
  final TextEditingController _emailCtrler = TextEditingController();

  late TabController _tabCtrler;
  List<TestContact> _contacts = [];
  @override
  void initState() {
    _refreshData();
    super.initState();
    _tabCtrler = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _nameCtrler.dispose();
    _phoneCtrler.dispose();
    _emailCtrler.dispose();
    _tabCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expense found. Spending some...'),
    );
    // if()
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 72, 180, 222),
            foregroundColor: Theme.of(context).secondaryHeaderColor,
            title: const Text('Student1328430'),
            bottom: TabBar(
              tabs: myTabs,
              controller: _tabCtrler,
            ),
          ),
          drawer: const DrawerMenu(),
          body: TabBarView(
              controller: _tabCtrler,
              children: myTabs.map((Tab tab) {
                if (_contacts.isNotEmpty) {
                  final String label = tab.text!.toLowerCase();
                  if (label == 'favorite') {
                    mainContent = ContactList(
                        _contacts.where((e) => e.isFavorite != 0).toList());
                  } else {
                    mainContent = ContactList(_contacts);
                  }
                }
                return Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.13),
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Text(
                          'Contacts',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(child: mainContent)
                    ],
                  ),
                );
              }).toList()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => const AddDialog());
            },
            child: const Icon(Icons.add),
          )),
    );
  }

  Future<void> _refreshData() async {
    await TetsRepository.getContacts().then((value) => _contacts = value);
    setState(() {});
  }

}
