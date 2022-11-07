import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/customer.dart';
import '../../../utils/utils.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    Key? key,
    required this.colorCustom,
    required this.currentData,
  }) : super(key: key);

  final ColorCustom colorCustom;
  final CustomerModel currentData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              'Jumlah',
              style: GoogleFonts.roboto(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 100,
                height: 40,
                color: colorCustom.greenPrimary,
                child: Center(
                  child: Text('Rp.${currentData.totalPrice}'),
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Text(
              'Dibayar',
              style: GoogleFonts.roboto(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 100,
                height: 40,
                color: colorCustom.bluePrimary,
                child: Center(
                  child: currentData.payNow != null
                      ? Text('Rp.${currentData.payNow}')
                      : const Text('Rp.0'),
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Text(
              'Sisa',
              style: GoogleFonts.roboto(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 100,
                height: 40,
                color: Colors.red.shade200,
                child: Center(
                  child: currentData.remindDebt != null
                      ? Text('Rp.${currentData.remindDebt}')
                      : const Text("Rp.0"),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
