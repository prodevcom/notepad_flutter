import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:notepad/helpers/snack.dart';
import 'package:notepad/screens/home/home.dart';

class RegisterController {
  final BuildContext _context;
  RegisterController._(this._context);

  // Attributes
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final checkPassword = TextEditingController();
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final checkPasswordFocus = FocusNode();

  factory RegisterController.of(BuildContext context) {
    return RegisterController._(context);
  }

  Future register() async {
    FocusScope.of(_context).unfocus();
    try {
      var currentUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await currentUser.user?.updateDisplayName(name.text).then((value) {
        Navigator.of(_context).pushReplacementNamed(HomeScreen.id);
      });
    } on FirebaseAuthException catch (error) {
      log("Firebase Error: ${error.toString()}", name: "LoginController");
      String errorMessage;
      switch (error.code) {
        case "email-already-in-use":
          errorMessage =
              "Ops... esta conta já esta cadastrada, tente utilizar outra ou volte e acesse a sua!";
          emailFocus.requestFocus();
          break;
        default:
          errorMessage =
              "Ops... alguma coisa esta fora do lugar, tente novamente mais tarde.";
          break;
      }
      SnackBarHelper.show(_context, message: errorMessage);
      // passwordFocus.requestFocus();
      // password.clear();
    } catch (error) {
      log("Error: ${error.toString()}", name: "LoginController");
    }
  }
}
