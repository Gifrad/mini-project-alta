import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/customer.dart';

class SecondBody extends StatelessWidget {
  const SecondBody({
    Key? key,
    required this.size,
    required this.currentData,
  }) : super(key: key);

  final Size size;
  final CustomerModel currentData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16),
          child: Text(
            'Item',
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          width: size.width,
          height: size.height * 0.12,
          child: Card(
            child: Center(
              heightFactor: 12,
              widthFactor: 12,
              child: Text(
                '${currentData.itemProduct}',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16),
          child: Text(
            'Item di bayar',
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          width: size.width,
          height: size.height * 0.12,
          child: Card(
            child: Center(
                heightFactor: 12,
                widthFactor: 12,
                child: currentData.itemPayNow != null
                    ? Text(
                        '${currentData.itemPayNow}',
                        style: GoogleFonts.roboto(fontSize: 16),
                      )
                    : Text(
                        'Tidak ada',
                        style: GoogleFonts.roboto(fontSize: 16),
                      )),
          ),
        ),
      ],
    );
  }
}
