import 'package:flutter/material.dart';
import 'package:pretest_prj/ver4/utils/snackbar_helper.dart';

class CheckboxOrRadio extends StatefulWidget {
  const CheckboxOrRadio({super.key});

  @override
  State<CheckboxOrRadio> createState() => _CheckboxOrRadioState();
}

enum CourseList { java, react, flutter }

class _CheckboxOrRadioState extends State<CheckboxOrRadio> {
  CourseList _course = CourseList.java;
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkbox and Radio button')),
      body: Column(
        children: [
          SizedBox(
            child: Column(
              children: CourseList.values
                  .map((e) => ListTile(
                      title: Text('${e.name} Course'),
                      leading: Radio(
                        value: e,
                        onChanged: (value) {
                          setState(() {
                            _course = value as CourseList;
                          });
                          SnackBarHelper.showSnackBar(
                              text: _course.name,
                              isSuccess: true,
                              context: context);
                        },
                        groupValue: _course,
                      )))
                  .toList(),
            ),
          ),
          ListTile(
            title: const Text('Java course'),
            leading: Radio(
              value: CourseList.java,
              groupValue: _course,
              onChanged: (value) {
                setState(() {
                  _course = value as CourseList;
                });
                SnackBarHelper.showSnackBar(
                    text: _course.name, isSuccess: true, context: context);
              },
            ),
          ),
          ListTile(
            title: const Text('React course'),
            leading: Radio(
              value: CourseList.react,
              groupValue: _course,
              onChanged: (value) {
                setState(() {
                  _course = value as CourseList;
                });
                SnackBarHelper.showSnackBar(
                    text: _course.name, isSuccess: true, context: context);
              },
            ),
          ),
          ListTile(
            title: const Text('Flutter course'),
            leading: Radio(
              value: CourseList.flutter,
              groupValue: _course,
              onChanged: (value) {
                setState(() {
                  _course = value as CourseList;
                });
                SnackBarHelper.showSnackBar(
                    text: _course.name, isSuccess: true, context: context);
              },
            ),
          ),

          /// CHECKBOX
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Checkbox with Header and Subtitle',
            style: TextStyle(fontSize: 20.0),
          ),
          CheckboxListTile(
            secondary: const Icon(Icons.alarm),
            title: const Text('Ringing at 4:30 AM every day'),
            subtitle: const Text('Ringing after 12 hours'),
            value: valuefirst,
            onChanged: (value) {
              setState(() {
                this.valuefirst = value as bool;
              });
            },
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            secondary: const Icon(Icons.alarm),
            title: const Text('Ringing at 5:00 AM every day'),
            subtitle: const Text('Ringing after 12 hours'),
            value: valuesecond,
            onChanged: (value) {
              setState(() {
                valuesecond = value as bool;
              });
            },
          ),
        ],
      ),
    );
  }
}
