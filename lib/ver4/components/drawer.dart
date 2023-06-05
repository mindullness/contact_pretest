import 'package:flutter/material.dart';
import 'package:pretest_prj/ver4/model/v4_contact.dart';
import 'package:pretest_prj/ver4/page/checkbox_radio.dart';
import 'package:pretest_prj/ver4/page/main_contact.dart';
import 'package:pretest_prj/ver4/page/manage_contact.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItem(context),
      ),
    );
  }

  List<Widget> buildMenuItem(BuildContext context) {
    final List<String> menuTitles = [
      'All Contacts',
      'Contact Management',
      'Checkbox or radio',
    ];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
      decoration: BoxDecoration(color: Colors.grey),
      padding: EdgeInsets.all(30),
      curve: Curves.bounceInOut,
      child: Text(
        'Fitness',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ));

    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(element, style: const TextStyle(fontSize: 18)),
        onTap: () {
          switch (element) {
            case 'All Contacts':
              screen = const MainContact();
              break;
            case 'Contact Management':
              screen = V4ManageContact(false, V4Contact('', ''));
              break;
            case 'Checkbox or radio':
              screen = const CheckboxOrRadio();
              break;
            default:
              break;
          }
          Navigator.pop(context);
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (ctx) => screen));
          Navigator.push(
              context,
              PageRouteBuilder<void>(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    // return const Center(child: Text('My PageRoute'));
                    return screen;
                  },
                  transitionsBuilder:
                      (___, Animation<double> animation, ____, Widget child) {
                    return FadeTransition(
                      opacity: animation,
                      child: RotationTransition(
                        turns: Tween<double>(begin: 0.5, end: 1.0)
                            .animate(animation),
                        child: child,
                      ),
                    );
                  }));
        },
      ));
    }
    return menuItems;
  }
}
