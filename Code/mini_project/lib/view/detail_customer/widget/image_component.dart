import 'package:flutter/material.dart';

import '../../../models/customer.dart';

class ImageComponent extends StatelessWidget {
  const ImageComponent({
    Key? key,
    required this.size,
    required this.currentData,
  }) : super(key: key);

  final Size size;
  final CustomerModel currentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage('${currentData.image}'),
        ),
      ),
    );
  }
}
