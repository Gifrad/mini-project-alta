import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/utils/utils.dart';
import 'package:mini_project/view/profile_store/profile_store_screen.dart';
import 'package:mini_project/view_model/customer.dart';
import 'package:provider/provider.dart';

import '../../view_model/profile_store.dart';
import '../detail_customer/detail_customer.dart';
import '../entry_customer/edit_entry_screen.dart';
import '../entry_customer/entry_screen.dart';
import '../entry_customer/pay_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth user = FirebaseAuth.instance;
  final colorCustom = ColorCustom();

  @override
  void initState() {
    Provider.of<CustomerViewModel>(context, listen: false).getCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataCustomer = Provider.of<CustomerViewModel>(context).dataCustomer;
    final dataCustomerLenght = dataCustomer.length;
    final sumPrice = dataCustomer.fold(
        0,
        ((sum, element) =>
            sum + num.parse(element.totalPrice.toString()).toInt()));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(10)),
            color: colorCustom.greenPrimary,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hai ${user.currentUser?.displayName}',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text('Selamat Datang!'),
                      ],
                    ),
                    Column(
                      children: [
                        StreamBuilder<DocumentSnapshot<Object?>>(
                          stream: Provider.of<ProfileStoreViewModel>(context,
                                  listen: false)
                              .getDataImgProfile(),
                          builder: (context, snapshot) {
                            Map<String, dynamic>? data =
                                snapshot.data?.data() as Map<String, dynamic>?;
                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: colorCustom.bluePrimary),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: data?['imageUrl'] != null
                                      ? NetworkImage("${data?['imageUrl']}")
                                      : const NetworkImage(
                                          'https://akornas.ac.id/wp-content/uploads/2021/12/placeholder.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              TransitionScreen(
                                beginLeft: 0.0,
                                beginRight: -1.0,
                                curvesAction: Curves.easeIn,
                                screen: const ProfileStoreScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Profile Warung",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Customer',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  color: colorCustom.greenPrimary,
                                  child: Center(
                                    child: Text(dataCustomerLenght.toString()),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(children: [
                            Text(
                              'Jumlah Hutang',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 100,
                                height: 40,
                                color: colorCustom.bluePrimary,
                                child: Center(
                                    child: sumPrice != 0
                                        ? Text('Rp :$sumPrice')
                                        : const Text('0')),
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<CustomerViewModel>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.dataCustomer.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    TransitionScreen(
                      beginLeft: 1.0,
                      beginRight: 0.0,
                      curvesAction: Curves.easeIn,
                      screen:
                          DetailCustomer(data: value.dataCustomer[index].id!),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: value
                                              .dataCustomer[index].image !=
                                          null
                                      ? NetworkImage(
                                          '${value.dataCustomer[index].image}')
                                      : const NetworkImage(
                                          'https://i0.wp.com/www.reviewtekno.com/wp-content/uploads/2022/09/pp-wa-kosong-biasa.webp?resize=192%2C192&ssl=1')),
                              const SizedBox(
                                width: 6,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${value.dataCustomer[index].name}',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    '${value.dataCustomer[index].numberPhone}',
                                    style: GoogleFonts.roboto(fontSize: 12),
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return FractionallySizedBox(
                                          heightFactor: 0.3,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              ListTile(
                                                leading: const Icon(Icons.edit),
                                                title: const Text('Edit'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    TransitionScreen(
                                                      beginLeft: 0.0,
                                                      beginRight: 1.0,
                                                      curvesAction:
                                                          Curves.easeIn,
                                                      screen: EditEntryScreen(
                                                          data: value
                                                              .dataCustomer[
                                                                  index]
                                                              .id!),
                                                    ),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.payment_sharp),
                                                title: const Text('Bayar'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    TransitionScreen(
                                                      beginLeft: 0.0,
                                                      beginRight: 1.0,
                                                      curvesAction:
                                                          Curves.easeIn,
                                                      screen: PayScreen(
                                                          data: value
                                                              .dataCustomer[
                                                                  index]
                                                              .id!),
                                                    ),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading:
                                                    const Icon(Icons.delete),
                                                title: const Text('Hapus'),
                                                onTap: () async {
                                                  final result = await value
                                                      .deleteCustomer(value
                                                          .dataCustomer[index]);
                                                  if (mounted) {}
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          result.toString()),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.menu))
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Hutang',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      color: colorCustom.greenPrimary,
                                      child: Center(
                                        child: Text(
                                            'Rp :${value.dataCustomer[index].totalPrice}'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text('${value.dataCustomer[index].createAt}'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            TransitionScreen(
              beginLeft: 0.0,
              beginRight: 1.0,
              curvesAction: Curves.easeIn,
              screen: const EntryScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
