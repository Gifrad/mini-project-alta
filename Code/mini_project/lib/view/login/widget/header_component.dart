import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/pict_login.png',
                  height: size.height * 0.3,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SELAMAT DATANG',
                      style: GoogleFonts.roboto(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Silahkan masuk terlebih dahulu!',
                      style: GoogleFonts.roboto(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
