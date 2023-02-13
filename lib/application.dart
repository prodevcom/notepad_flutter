import 'package:flutter/material.dart';

import 'package:notepad/system/routes.dart';
import 'package:notepad/system/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NodePad',
      theme: SystemTheme.lightness,
      darkTheme: SystemTheme.darkness,
      initialRoute: SystemRoutes.initialRoute,
      routes: SystemRoutes.routes,
    );
  }
}
