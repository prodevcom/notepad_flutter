import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:notepad/helpers/snack.dart';
import 'package:notepad/screens/home/home.dart';

class LoginController {
  final BuildContext _context;
  LoginController._(this._context);

  // Attributes
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  factory LoginController.of(BuildContext context) {
    return LoginController._(context);
  }

  Future authenticate() async {
    FocusScope.of(_context).unfocus();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((_) =>
              Navigator.of(_context).pushReplacementNamed(HomeScreen.id));
    } on FirebaseAuthException catch (error) {
      log("Firebase Error: ${error.toString()}", name: "LoginController");

      String errorMessage;
      switch (error.code) {
        case 'user-not-found':
          errorMessage =
              "Ops... você ainda não tem cadastro! Clique em \"Cadastrar\" para fazer parte da nossa comunidade!";
          break;
        case 'wrong-password':
          errorMessage = "Ops.. os dados preenchidos não conferem!";
          break;
        default:
          errorMessage =
              "Ops... alguma coisa esta fora do lugar, tente novamente mais tarde.";
          break;
      }
      SnackBarHelper.show(_context, message: errorMessage);
      passwordFocus.requestFocus();
      password.clear();
    } catch (error) {
      log("Error: ${error.toString()}", name: "LoginController");
    }
  }
}
