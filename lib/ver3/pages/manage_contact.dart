import 'package:flutter/material.dart';
import 'package:pretest_prj/ver3/db/contact_service.dart';
import 'package:pretest_prj/ver3/models/v3_contact.dart';

class ManageContact extends StatefulWidget {
  final bool isNew;
  final V3Contact contact;
  const ManageContact({
    super.key,
    required this.isNew,
    required this.contact,
  });

  @override
  State<ManageContact> createState() => _ManageContactState();
}

class _ManageContactState extends State<ManageContact> {
  final TextEditingController _nameCtrler = TextEditingController();
  final TextEditingController _phoneCtrler = TextEditingController();

  @override
  void dispose() {
    _nameCtrler.clear();
    _phoneCtrler.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Management'),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        alignment: Alignment.center,
        child: Column(
            children: [
          TextField(
            controller: _nameCtrler,
            decoration: const InputDecoration(hintText: 'Enter name...'),
          ),
          TextField(
            controller: _phoneCtrler,
            decoration: const InputDecoration(hintText: 'Enter phone...'),
          ),
          ElevatedButton(onPressed: _onCreate, child: const Text('Create'))
        ]
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: e,
                    ))
                .toList()),
      ),
    );
  }

  void _onCreate() {
    if (!_isValid()) {
      return;
    }
    widget.contact.name = _nameCtrler.text;
    widget.contact.phone = _phoneCtrler.text;
    ContactService.insert(widget.contact).then((value) => {
          if (value)
            {
              Navigator.pop(context),
              // Navigator.pushReplacementNamed(context, '/'),
              Navigator.popAndPushNamed(context, '/'),
              _showSnackBar(
                  text: ' Add new contact successfully!', isSuccess: true)
            }
          else
            {
              _showSnackBar(
                  text: ' Add contact unsuccessfully!', isSuccess: false)
            }
        });
  }

  bool _isValid() {
    if (_nameCtrler.text.isEmpty) {
      _showSnackBar(text: ' Name is required!', isSuccess: false);
      return false;
    } else if (_phoneCtrler.text.isEmpty) {
      _showSnackBar(text: ' Phone is required!', isSuccess: false);
      return false;
    }
    return true;
  }

  _showSnackBar({text, isSuccess}) {
    Icon icon;
    MaterialColor color;
    if (isSuccess) {
      color = Colors.green;
      icon = Icon(Icons.done, color: color);
    } else {
      color = Colors.red;
      icon = Icon(Icons.error_outline, color: color);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      showCloseIcon: true,
      closeIconColor: color,
      duration: const Duration(seconds: 2),
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        icon,
        Text(text, style: TextStyle(color: color)),
      ]),
    ));
  }
}
