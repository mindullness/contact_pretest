import 'package:flutter/material.dart';
import 'package:pretest_prj/ver2/repository/contact_repository.dart';
import 'package:pretest_prj/ver2/models/contact.dart';

class ContactActivities extends StatefulWidget {
  final Contact contact;
  final bool isNew;

  const ContactActivities(this.isNew, this.contact, {super.key});

  @override
  State<ContactActivities> createState() => _ContactActivitiesState();
}

class _ContactActivitiesState extends State<ContactActivities> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _nameCtrler = TextEditingController();
  final TextEditingController _phoneCtrler = TextEditingController();
  final ContactRepository _repository = ContactRepository();

  @override
  void initState() {
    if (!widget.isNew) {
      _nameCtrler.text = widget.contact.name;
      _phoneCtrler.text = widget.contact.phone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Contact Management'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white70,
        ),
        body: Center(
          child: SizedBox(
            height: 250,
            width: 300,
            child: Column(
                children: [
              TextField(
                autofocus: true,
                controller: _nameCtrler,
                decoration: const InputDecoration(hintText: 'Enter name...'),
              ),
              TextField(
                controller: _phoneCtrler,
                decoration: const InputDecoration(hintText: 'Enter phone...'),
              ),
              ElevatedButton(
                onHover: (value) {},
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
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                    mouseCursor: MaterialStateMouseCursor.clickable),
                child: Text(
                  widget.isNew ? 'Create' : 'Update',
                  style: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  if (!_isValid()) {
                    return;
                  }
                  widget.contact.name = _nameCtrler.text;
                  widget.contact.phone = _phoneCtrler.text;
                  if (widget.isNew) {
                    handleInsert(context);
                  } else {
                    handleUpdate(context);
                  }
                },
              ),
            ]
                    .map((e) =>
                        Padding(padding: const EdgeInsets.all(8), child: e))
                    .toList()),
          ),
        ),
      ),
    );
  }

  Future<void> handleUpdate(BuildContext context) async {
    await _repository
        .update(widget.contact)
        .then((result) => result
            ? {
                Navigator.popAndPushNamed(context, '/'),
                _showSnackBar(
                    text: 'Update successfully',
                    isSuccess: true,
                    type: 'update')
              }
            : _showSnackBar(
                text: 'Cannot update new contact!',
                isSuccess: false,
                type: 'update'))
        .catchError((err) =>
            _showSnackBar(text: err, isSuccess: false, type: 'update'));
  }

  Future<void> handleInsert(BuildContext context) async {
    await _repository
        .insert(widget.contact)
        .then((result) => result
            ? {
                Navigator.of(context).pop(true),
                Navigator.popAndPushNamed(context, '/'),
                _showSnackBar(
                    text: 'Add successfully', isSuccess: true, type: 'add')
              }
            : _showSnackBar(
                text: 'Cannot insert new contact!',
                isSuccess: false,
                type: 'add'))
        .catchError(
            (err) => _showSnackBar(text: err, isSuccess: false, type: 'add'));
  }

  bool _isValid() {
    String name = _nameCtrler.text;
    String phone = _phoneCtrler.text;
    if (name.isEmpty) {
      _showSnackBar(text: "Please enter name", isSuccess: false, type: 'name');
      return false;
    } else if (phone.isEmpty) {
      _showSnackBar(
          text: "Please enter mobile", isSuccess: false, type: 'phone');
      return false;
    }
    return true;
  }

  _showSnackBar({text, isSuccess, type}) {
    Icon icon;
    MaterialColor textColor;
    if (isSuccess) {
      textColor = Colors.green;
      icon = const Icon(Icons.done, color: Colors.green);
    } else {
      textColor = Colors.red;
      icon = const Icon(Icons.error_outline, color: Colors.red);
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        icon,
        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
        Text(text, style: TextStyle(color: textColor)),
      ],
    )));
  }
}
