import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/view/home/home_screen.dart';
import 'package:mini_project/view/login/widget/form_card.dart';
import 'package:mini_project/view/login/widget/header_component.dart';

import 'widget/move_signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    validateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/background_login_top.png',
                width: size.width * 0.40,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/background_login_bottom.png',
                width: size.width * 0.40,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  HeaderComponent(),
                  FormCard(),
                  SignUp(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateUser() {
    FirebaseAuth resultUser = FirebaseAuth.instance;
    resultUser.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          return;
        } else {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false);
          }
        }
      },
    );
  }
}
