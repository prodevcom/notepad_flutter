import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:notepad/application.dart';
import 'package:notepad/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var analyticsOption = DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(name: "NotePad", options: analyticsOption);

  runApp(const Application());
}
