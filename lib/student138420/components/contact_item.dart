import 'package:flutter/material.dart';
import 'package:pretest_prj/student138420/db/repo/contact_repository.dart';
import 'package:pretest_prj/student138420/models/test_contact.dart';
import 'package:pretest_prj/ver4/utils/snackbar_helper.dart';

class ContactItem extends StatelessWidget {
  const ContactItem(this.e, {super.key});
  final TestContact e;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: const Color.fromARGB(162, 204, 34, 204),
      child: SizedBox(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(children: [
                Text(e.name),
                Text(e.phone),
              ]),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  e.isFavorite = e.isFavorite == 0 ? 1 : 0;
                  TetsRepository.update(e).then((value) => {
                        if (value)
                          {
                            // Navigator.pop(context),
                            Navigator.pushReplacementNamed(context, '/'),
                            // Navigator.popAndPushNamed(
                            //     context, '/'),
                            SnackBarHelper.showSnackBar(
                                text: ' Update new contact successfully!',
                                isSuccess: true,
                                context: context)
                          }
                        else
                          {
                            SnackBarHelper.showSnackBar(
                                text: ' Add contact unsuccessfully!',
                                isSuccess: false,
                                context: context)
                          }
                      });
                },
                icon: Icon(Icons.favorite,
                    color: e.isFavorite != 0 ? Colors.pink : Colors.white)),
          ],
        ),
      ),
    );
  }
}
