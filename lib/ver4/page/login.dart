import 'package:flutter/material.dart';
import 'package:pretest_prj/ver4/db/user_repository.dart';
import 'package:pretest_prj/ver4/model/user.dart';
import 'package:pretest_prj/ver4/utils/snackbar_helper.dart';

class Login extends StatefulWidget {
  bool isNew;
  Login(this.isNew, {super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameCtrler = TextEditingController();
  final TextEditingController _passwordCtrler = TextEditingController();
  bool isChecked = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameCtrler.dispose();
    _passwordCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return Color.fromARGB(255, 82, 108, 255);
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.isNew ? 'Signup' : 'Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
        child: Column(
            children: [
          TextField(
            controller: _usernameCtrler,
            decoration: const InputDecoration(hintText: 'Enter username...'),
          ),
          TextField(
            controller: _passwordCtrler,
            decoration: const InputDecoration(hintText: 'Enter password...'),
          ),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            activeColor: Colors.blue,
            onChanged: (value) => setState(() {
              isChecked = value as bool;
            }),
          ),
          ElevatedButton(
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>(getColor),
                shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)))),
                mouseCursor: MaterialStateMouseCursor.clickable),
            onPressed: _handleLogin,
            child: Text(
              widget.isNew ? 'Signup' : 'Login',
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
    );
  }

  _handleLogin() async {
    User _user = User(_usernameCtrler.text, _passwordCtrler.text);
    if (widget.isNew) {
      // final insertUser = UserRepository.insert(loginUser);
      await UserRepository.signup(_user).then((value) =>
          SnackBarHelper.showSnackBar(
              text: value, isSuccess: true, context: context));
    } else {
      await UserRepository.login(_user).then((value) =>
          SnackBarHelper.showSnackBar(
              text: value.toString(), isSuccess: true, context: context));
    }
  }
}
