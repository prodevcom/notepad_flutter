import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:notepad/screens/home/home.dart';
import 'package:notepad/screens/login/login.dart';
import 'package:notepad/widget/scrollview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "/splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((_) {
      var user = FirebaseAuth.instance.currentUser;
      var route = (user != null) ? HomeScreen.id : LoginScreen.id;
      Navigator.pushReplacementNamed(context, route);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WScrollView(
        center: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
                radius: 72,
                backgroundImage: AssetImage("./assets/icons/laucher_icon.png")),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
