import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/utils/utils.dart';
import 'package:mini_project/view/home/home_screen.dart';
import 'package:mini_project/view_model/customer.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/customer.dart';
import '../../view_model/profile_store.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _numberPhoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _itemHutangController;
  late final TextEditingController _totalHargaController;
  String imageUrl = '';

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _numberPhoneController = TextEditingController();
    _addressController = TextEditingController();
    _itemHutangController = TextEditingController();
    _totalHargaController = TextEditingController();
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
        title: const Text('Tambah Customer'),
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
                            fit: BoxFit.contain,
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
                        'Isi Data tambah Customer!',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                    ],
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
                              labelText: 'Name',
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
                            keyboardType: TextInputType.number,
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
                        'Isi item product dan harga!',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                    ],
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
                                    keyboardType: TextInputType.number,
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
                    height: 6,
                  ),
                  Consumer<CustomerViewModel>(
                    builder: (context, value, child) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            final uId = const Uuid().v1();
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
                                CustomerModel cust = CustomerModel(
                                  id: uId,
                                  image: imageUrl,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  createAt: dateTime,
                                  numberPhone: _numberPhoneController.text,
                                  address: _addressController.text,
                                  itemProduct: _itemHutangController.text,
                                  totalPrice: _totalHargaController.text,
                                );

                                final result = await value.addCustomer(cust);
                                value.dataCustomer.clear();
                                if (mounted) {}
                                Navigator.pushReplacement(
                                  context,
                                  TransitionScreen(
                                    beginLeft: 0.0,
                                    beginRight: 0.0,
                                    curvesAction: Curves.ease,
                                    screen: const HomeScreen(),
                                  ),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result.toString(),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Tambah'),
                        ),
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
