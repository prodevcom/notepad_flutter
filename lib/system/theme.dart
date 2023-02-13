import 'package:flutter/material.dart';

class SystemTheme {
  SystemTheme._();

  static ThemeData get lightness => ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      );

  static ThemeData get darkness => ThemeData(
        brightness: Brightness.dark,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      );
}
