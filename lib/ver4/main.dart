import 'package:flutter/material.dart';
import 'package:pretest_prj/ver4/page/checkbox_radio.dart';
import 'package:pretest_prj/ver4/page/login.dart';
import 'package:pretest_prj/ver4/page/main_contact.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 218, 215, 225),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
  brightness: Brightness.dark,
);

void main(List<String> args) {
  runApp(const Ver4());
}

class Ver4 extends StatelessWidget {
  const Ver4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.primary,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorScheme.onPrimaryContainer,
                foregroundColor: kDarkColorScheme.primaryContainer),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: kDarkColorScheme.onPrimary,
          )),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.primary,
                fontSize: 18,
              ),
              titleSmall: TextStyle(
                fontWeight: FontWeight.w300,
                color: kColorScheme.primary.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainContact(),
        '/login':(context) => Login(false),
         '/signup':(context) => Login(true),
         '/cr':(context) => const CheckboxOrRadio()
      },
    );
  }
}
