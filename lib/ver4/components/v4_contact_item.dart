import 'package:flutter/material.dart';
import 'package:pretest_prj/ver4/model/v4_contact.dart';

class V4ContactItem extends StatelessWidget {
  final V4Contact contact;
  const V4ContactItem(this.contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_rounded),
            Text(contact.name, style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            const Icon(Icons.phone_iphone),
            Text(contact.phone, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
