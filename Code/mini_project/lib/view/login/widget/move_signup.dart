import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/utils/utils.dart';

import '../../register/register_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Belum punya Akun?',
            style: GoogleFonts.roboto(fontSize: 12),
          ),
          const SizedBox(
            width: 4,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                TransitionScreen(
                  beginLeft: 1.0,
                  beginRight: 0.0,
                  curvesAction: Curves.easeIn,
                  screen: const RegisterScreen(),
                ),
              );
            },
            child: Text(
              'Daftar',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
