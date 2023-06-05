import 'package:flutter/material.dart';
import 'package:pretest_prj/ver4/db/contact_repository.dart';
import 'package:pretest_prj/ver4/model/v4_contact.dart';

class V4ManageContact extends StatefulWidget {
  final bool isNew;
  final V4Contact contact;

  const V4ManageContact(this.isNew, this.contact, {super.key});

  @override
  State<V4ManageContact> createState() => _V4ManageContactState();
}

class _V4ManageContactState extends State<V4ManageContact> {
  final TextEditingController _nameCtrler = TextEditingController();
  final TextEditingController _phoneCtrler = TextEditingController();

  @override
  void dispose() {
    _nameCtrler.dispose();
    _phoneCtrler.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (!widget.isNew) {
      _nameCtrler.text = widget.contact.name;
      _phoneCtrler.text = widget.contact.phone;
    }
    setState(() {});
    super.initState();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
              ElevatedButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromARGB(255, 46, 199, 194);
                        }
                        //<-- SEE HERE
                        return null; // Defer to the widget's default.
                      },
                    ),
                    shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                    mouseCursor: MaterialStateMouseCursor.clickable),
                onPressed: _handleSubmit,
                child: Text(
                  widget.isNew ? 'Create' : 'Update',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: e,
                        ))
                    .toList()),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (!_isValid()) {
      return;
    }
    widget.contact.name = _nameCtrler.text;
    widget.contact.phone = _phoneCtrler.text;
    if (widget.isNew) {
      ContactRepository.insert(widget.contact).then((value) => {
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
    } else {
      ContactRepository.update(widget.contact).then((value) => {
            if (value)
              {
                Navigator.pop(context),
                // Navigator.pushReplacementNamed(context, '/'),
                Navigator.popAndPushNamed(context, '/'),
                _showSnackBar(
                    text: ' Update new contact successfully!', isSuccess: true)
              }
            else
              {
                _showSnackBar(
                    text: ' Update contact unsuccessfully!', isSuccess: false)
              }
          });
    }
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
