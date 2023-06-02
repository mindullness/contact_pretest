import 'package:flutter/material.dart';
import 'package:pretest_prj/ver2/pages/main_activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => const MainActivity(),
      },
    );
  }
}
