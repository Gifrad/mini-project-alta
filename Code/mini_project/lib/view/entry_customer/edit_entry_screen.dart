import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../../utils/utils.dart';
import '../../view_model/customer.dart';
import '../../view_model/profile_store.dart';
import '../home/home_screen.dart';

class EditEntryScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const EditEntryScreen({super.key, this.data});

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _numberPhoneController =
      TextEditingController();
  late final TextEditingController _addressController = TextEditingController();
  late final TextEditingController _itemHutangController =
      TextEditingController();
  late final TextEditingController _totalHargaController =
      TextEditingController();
  String imageUrl = '';

  @override
  void initState() {
    final currentCustomer =
        Provider.of<CustomerViewModel>(context, listen: false)
            .selectById(widget.data);
    _nameController.text = currentCustomer.name!;
    _itemHutangController.text = currentCustomer.itemProduct!;
    _emailController.text = currentCustomer.email!;
    _totalHargaController.text = currentCustomer.totalPrice!;
    _numberPhoneController.text = currentCustomer.numberPhone!;
    _addressController.text = currentCustomer.address!;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _itemHutangController.dispose();
    _totalHargaController.dispose();
    _numberPhoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColor = ColorCustom();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor.bluePrimary,
        title: const Text('Edit Customer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: Provider.of<ProfileStoreViewModel>(context,
                            listen: false)
                        .getDataImgProfile(),
                    builder: (context, snapshot) {
                      Map<String, dynamic>? data =
                          snapshot.data?.data() as Map<String, dynamic>?;
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.black),
                          image: DecorationImage(
                            scale: 1.0,
                            image: data?['imageUrl'] != null
                                ? NetworkImage("${data?['imageUrl']}")
                                : const NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/004/511/733/original/camera-icon-on-white-background-vector.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: Provider.of<ProfileStoreViewModel>(context,
                            listen: false)
                        .getDataProfile(),
                    builder: (context, snapshot) {
                      Map<String, dynamic>? data =
                          snapshot.data?.data() as Map<String, dynamic>?;
                      return data?['nameStore'] != null
                          ? Text(
                              '"${data?['nameStore']}"',
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              '"N/A"',
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Customer',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Pastikan data sudah benar!',
                        style: GoogleFonts.roboto(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                showModalCustom(context);
                              },
                              leading: const Icon(Icons.image),
                              title: const Text('Ambil Gambar'),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              labelText: 'Nama',
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
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator: (email) {
                              if (email != null &&
                                  !EmailValidator.validate(email)) {
                                return 'Masukan Email dengan benar';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _numberPhoneController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              labelText: 'Nomer Hp',
                              prefix: const Text('+62 : '),
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
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: 'Alamat',
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Silahkan edit jika data salah',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Item Product'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    maxLines: 3,
                                    controller: _itemHutangController,
                                    decoration: InputDecoration(
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
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Total Harga'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    controller: _totalHargaController,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<CustomerViewModel>(
                    builder: (context, value, child) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        onPressed: () async {
                          final idCustomer = Provider.of<CustomerViewModel>(
                                  context,
                                  listen: false)
                              .selectById(widget.data);
                          final dateTime = DateFormat('yyyy-MM-dd – kk:mm')
                              .format(DateTime.now())
                              .toString();
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (imageUrl == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Mohon masukan gambar Customer'),
                                ),
                              );
                            } else {
                              value.dataCustomer.clear();
                              CustomerModel cust = CustomerModel(
                                id: idCustomer.id,
                                image: imageUrl,
                                name: _nameController.text,
                                email: _emailController.text,
                                createAt: dateTime,
                                numberPhone: '62${_numberPhoneController.text}',
                                address: _addressController.text,
                                itemProduct: _itemHutangController.text,
                                totalPrice: _totalHargaController.text,
                              );

                              final result = await value.updateCustomer(cust);
                              if(mounted){}
                              Navigator.pushReplacement(
                                context,
                                TransitionScreen(
                                  beginLeft: 0.0,
                                  beginRight: 0.0,
                                  curvesAction: Curves.easeIn,
                                  screen: const HomeScreen(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.toString())));
                            }
                          }
                        },
                        child: const Text('Edit'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showModalCustom(BuildContext context) {
    Reference refInstance = FirebaseStorage.instance.ref();
    ImagePicker imagePicker = ImagePicker();
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.camera);
                  if (file == null) return;
                  Reference refDirImage = refInstance.child('customer');
                  Reference refImageToUpload =
                      refDirImage.child(uniqueFileName);
                  try {
                    await refImageToUpload.putFile(File(file.path));
                    imageUrl = await refImageToUpload.getDownloadURL();
                    if (mounted) {}
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gambar Berhasil Di Upload'),
                      ),
                    );
                  } catch (e) {
                    if (mounted) {}
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gagal Upload Gambar'),
                      ),
                    );
                  }
                  if (mounted) {}
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Galery'),
                onTap: () async {
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  if (file == null) return;
                  Reference refDirImage = refInstance.child('customer');
                  Reference refImageToUpload =
                      refDirImage.child(uniqueFileName);
                  try {
                    await refImageToUpload.putFile(File(file.path));
                    imageUrl = await refImageToUpload.getDownloadURL();
                    if (mounted) {}
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gambar Berhasil Di Upload'),
                      ),
                    );
                  } catch (e) {
                    if (mounted) {}
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gagal Upload Gambar'),
                      ),
                    );
                  }
                  if (mounted) {}
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
