import 'package:flutter/material.dart';
import 'package:mini_project/view/register/widget/form_card.dart';
import 'package:mini_project/view/register/widget/header.dart';
import 'widget/move_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                'assets/bg_register_top.png',
                width: size.width * 0.50,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/bg_register_bottom.png',
                width: size.width * 0.25,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  HeaderRegister(),
                  FormCardRegister(),
                  MoveLogin(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
