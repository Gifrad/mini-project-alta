import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../../utils/utils.dart';
import '../../view_model/customer.dart';
import '../home/home_screen.dart';

class PayScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const PayScreen({super.key, this.data});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _payNowController;
  late final TextEditingController _itemPayNowController;
  late final TextEditingController _remindDebtController;

  @override
  void initState() {
    _payNowController = TextEditingController();
    _itemPayNowController = TextEditingController();
    _remindDebtController = TextEditingController();
    final currentCustomer =
        Provider.of<CustomerViewModel>(context, listen: false)
            .selectById(widget.data);

    final itemProduct = currentCustomer.itemPayNow;
    final payNow = currentCustomer.payNow;
    final remindDebt = currentCustomer.remindDebt;
    if (itemProduct != null) {
      _itemPayNowController.text = currentCustomer.itemPayNow!;
    }
    if (payNow != null) {
      _payNowController.text = currentCustomer.payNow!;
    }
    if (remindDebt != null) {
      _remindDebtController.text = currentCustomer.remindDebt!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _payNowController.dispose();
    _itemPayNowController.dispose();
    _remindDebtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorCostom = ColorCustom();

    Size size = MediaQuery.of(context).size;
    final currentCustomer =
        Provider.of<CustomerViewModel>(context, listen: false)
            .selectById(widget.data);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                "FORM PEMBAYARAN",
                style: GoogleFonts.roboto(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Container(
                width: size.width * 0.3,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.black),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('${currentCustomer.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                '${currentCustomer.name}',
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Item Product Hutang Saat ini',
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.090,
                child: Card(
                  color: colorCostom.bluePrimary,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('${currentCustomer.itemProduct}'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total Harga',
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.080,
                      child: Card(
                        color: colorCostom.bluePrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Rp.${currentCustomer.totalPrice}'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Silahkan Isi Jika Customer Membayar Hutang',
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Item Product yang akan di bayar',
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.9,
                child: Card(
                  child: TextFormField(
                    controller: _itemPayNowController,
                    decoration: InputDecoration(
                      hintText: 'Item',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Total bayar',
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.06,
                        child: TextFormField(
                          controller: _payNowController,
                          decoration: InputDecoration(
                            prefix: const Text('Rp.'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Sisa Hutang',
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.06,
                        child: TextFormField(
                          controller: _remindDebtController,
                          decoration: InputDecoration(
                            prefix: const Text('Rp.'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<CustomerViewModel>(
                builder: (context, value, child) => SizedBox(
                  width: size.width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          CustomerModel cust = CustomerModel(
                            id: currentCustomer.id,
                            payNow: _payNowController.text,
                            itemPayNow: _itemPayNowController.text,
                            remindDebt: _remindDebtController.text,
                          );

                          value.updatePayCustomer(cust);
                          value.dataCustomer.clear();
                          Navigator.pushReplacement(
                            context,
                            TransitionScreen(
                              beginLeft: 0.0,
                              beginRight: 0.0,
                              curvesAction: Curves.easeIn,
                              screen: const HomeScreen(),
                            ),
                          );
                        }
                      },
                      child: const Text('Bayar'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
