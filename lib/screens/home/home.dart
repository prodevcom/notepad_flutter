import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:notepad/screens/home/components/note_view.dart';
import 'package:notepad/screens/home/controller/home.controller.dart';
import 'package:notepad/screens/notepad/note_pad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    controller = HomeController.of(context);
    super.initState();
  }

  List<Widget> actions() {
    return [
      IconButton(
        onPressed: controller.signOut,
        icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.firstName),
        actions: actions(),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: controller.getNotes(),
        builder: (_, snapshot) => NoteViewWidget(snapshot: snapshot),
      ),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () => Navigator.of(context).pushNamed(NotePadScreen.id),
      ),
    );
  }
}
