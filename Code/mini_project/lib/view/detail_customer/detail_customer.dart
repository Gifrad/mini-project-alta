import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../view_model/customer.dart';
import 'widget/body_first.dart';
import 'widget/body_second.dart';
import 'widget/button_component.dart';
import 'widget/image_component.dart';

class DetailCustomer extends StatelessWidget {
  final String data;
  const DetailCustomer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colorCustom = ColorCustom();
    final currentData =
        Provider.of<CustomerViewModel>(context, listen: false).selectById(data);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorCustom.greenPrimary,
        title: const Text('Detail Customer'),
        centerTitle: true,
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: NetworkImage('${currentData.image}'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Nama                  : ${currentData.name}',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Email                  : ${currentData.email}',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Number Phone : ${currentData.numberPhone}',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Alamat               : ${currentData.address}',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Di daftarkan      : ${currentData.createAt}',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      var androidUrl =
                                          "whatsapp://send?phone=${currentData.numberPhone}&text=Hello ${currentData.name}";

                                      try {
                                        await launchUrl(Uri.parse(androidUrl));
                                      } on Exception {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "WhatsApp belum di instal"),
                                          ),
                                        );
                                      }

                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.whatsapp)),
                                IconButton(
                                    onPressed: () {
                                      launchUrlString(
                                          'sms://${currentData.numberPhone}');
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.message)),
                                IconButton(
                                    onPressed: () {
                                      launchUrlString(
                                          'tel://${currentData.numberPhone}');
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.phone)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.person)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageComponent(size: size, currentData: currentData),
            BodyFirst(currentData: currentData),
            SecondBody(size: size, currentData: currentData),
            ButtonComponent(colorCustom: colorCustom, currentData: currentData)
          ],
        ),
      ),
    );
  }
}
