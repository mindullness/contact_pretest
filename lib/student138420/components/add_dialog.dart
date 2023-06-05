import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pretest_prj/student138420/db/repo/contact_repository.dart';
import 'package:pretest_prj/student138420/models/test_contact.dart';
import 'package:pretest_prj/student138420/utils/snackbar_helper.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final TextEditingController _nameCtrler = TextEditingController();
  final TextEditingController _phoneCtrler = TextEditingController();
  final TextEditingController _emailCtrler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Contact'),
      content: Column(
        children: [
          TextField(
            controller: _nameCtrler,
            decoration: const InputDecoration(hintText: 'Enter name...'),
          ),
          TextField(
            controller: _phoneCtrler,
            decoration: const InputDecoration(hintText: 'Enter phone...'),
          ),
          TextField(
            controller: _emailCtrler,
            decoration: const InputDecoration(hintText: 'Enter email...'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              String errText = _isValid();
              if (errText != '') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Invalid input'),
                    content: Text(
                        'Please make sure:\n"$errText" was entered valid!'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Ok')),
                    ],
                  ),
                );
                return;
              }
              String name = _nameCtrler.text;
              String phone = _phoneCtrler.text;
              String email = _emailCtrler.text;
              TestContact user = TestContact(name, phone, email, 0);

              TetsRepository.insert(user).then((value) => {
                    if (value)
                      {
                        Navigator.pop(context),
                        // Navigator.pushReplacementNamed(context, '/'),
                        Navigator.popAndPushNamed(context, '/'),
                        SnackBarHelper.showSnackBar(
                            text: ' Add new contact successfully!',
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
              // Navigator.of(context).pop(true);
            },
            child: const Text('Add')),
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'))
      ],
    );
  }

  String _isValid() {
    String textErr = '';
    if (_nameCtrler.text.isEmpty) {
      textErr = ' Name';
    } else if (_phoneCtrler.text.isEmpty) {
      textErr = ' Phone';
    } else if (_emailCtrler.text.isEmpty || !EmailValidator.validate(_emailCtrler.text)) {
       textErr = ' Email';
    }
    return textErr;
  }
}
