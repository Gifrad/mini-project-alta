import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../../models/customer.dart';

class BodyFirst extends StatelessWidget {
  const BodyFirst({
    Key? key,
    required this.currentData,
  }) : super(key: key);

  final CustomerModel currentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentData.name!,
                style: GoogleFonts.roboto(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text(currentData.numberPhone!),
            ],
          ),
          Text(currentData.createAt!),
        ],
      ),
    );
  }
}
