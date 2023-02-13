import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notepad/application/services/note_pad.dart';
import 'package:notepad/screens/login/login.dart';

class HomeController {
  final BuildContext _context;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  HomeController._(this._context);

  factory HomeController.of(BuildContext context) {
    return HomeController._(context);
  }

  String? getUserId() {
    var currentUser = FirebaseAuth.instance.currentUser;
    var userId = currentUser?.uid;
    return userId;
  }

  String get firstName {
    var displayName = _auth.currentUser?.displayName ?? "Anônimo";
    return "Olá, ${displayName.split(" ").first}";
  }

  Stream<QuerySnapshot<Object?>> getNotes() {
    var userId = getUserId() ?? "none-user-data";
    return NotePadService.notes(userId);
  }

  void signOut() {
    _auth.signOut().then((value) {
      Navigator.of(_context).pushReplacementNamed(LoginScreen.id);
    });
  }
}
