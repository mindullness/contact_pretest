import 'package:flutter/material.dart';

class SnackBarHelper{
  static showSnackBar({text, isSuccess, context}) {
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