import 'package:flutter/material.dart';
import 'package:pretest_prj/ver3/pages/all_contacts.dart';

void main(List<String> args) {
  runApp(const MyAppV4());
}

class MyAppV4 extends StatelessWidget {
  const MyAppV4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => const AllContacts(),
      },
    );
  }
}
