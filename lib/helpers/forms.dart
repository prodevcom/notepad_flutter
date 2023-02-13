import 'package:flutter/material.dart';

class FormsHelper {
  static bool validate(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }
}
