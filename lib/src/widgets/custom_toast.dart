import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomToast {
  final String message;
  final IconData icon;
  final Color color;

  const CustomToast(this.message, this.icon, this.color);
  void show(context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: color,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: color,
    ).show(context);
  }

}
