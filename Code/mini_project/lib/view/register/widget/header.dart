import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderRegister extends StatelessWidget {
  const HeaderRegister({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'BUAT AKUN',
          style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Silahkan isi Form Sesuai ketentuan',
          style: GoogleFonts.roboto(fontSize: 12),
        ),
        Image.asset(
          'assets/register_pict.png',
          width: size.width * 0.6,
        ),
      ],
    );
  }
}
