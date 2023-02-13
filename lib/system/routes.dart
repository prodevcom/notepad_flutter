import 'package:flutter/material.dart';

import 'package:notepad/screens/home/home.dart';
import 'package:notepad/screens/login/login.dart';
import 'package:notepad/screens/notepad/note_pad.dart';
import 'package:notepad/screens/register/register.dart';
import 'package:notepad/screens/splash/splash.dart';

class SystemRoutes {
  SystemRoutes._();

  static String get initialRoute => SplashScreen.id;

  static T? getArguments<T>(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) return null;
    return args as T;
  }

  static Map<String, Widget Function(BuildContext)> get routes => {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        NotePadScreen.id: (context) {
          var args = getArguments<NotePadScreenArgs>(context);
          return NotePadScreen(args: args);
        },
      };
}
