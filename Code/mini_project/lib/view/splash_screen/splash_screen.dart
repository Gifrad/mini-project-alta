import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_project/utils/utils.dart';
import '../login/login_screen.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key});

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {

  @override
  void dispose() {
    const CircularProgressIndicator();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final customColor = ColorCustom();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Image.asset('assets/logo3.png')),
            CircularProgressIndicator(
              backgroundColor: customColor.bluePrimary,
              color: customColor.greenPrimary,
            ),
          ],
        ),
      )),
    );
  }
}
