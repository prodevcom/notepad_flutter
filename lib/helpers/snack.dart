import 'package:flutter/material.dart';

class SnackBarHelper {
  SnackBarHelper._();
  static show(BuildContext context, {required String message}) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
