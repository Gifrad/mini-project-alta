import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../login/login_screen.dart';

class MoveLogin extends StatelessWidget {
  const MoveLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Sudah punya Akun?',
            style: GoogleFonts.roboto(fontSize: 12),
          ),
          const SizedBox(
            width: 4,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text(
              'Masuk',
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
