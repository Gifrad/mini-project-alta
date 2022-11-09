import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_project/models/profile_store.dart';
import 'package:mini_project/view/profile_store/profile_store_screen.dart';
import 'package:mini_project/view_model/profile_store.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameStoreCntrl;
  late TextEditingController _addressStoreCntrl;
  late TextEditingController _numberPhoneStoreCntrl;
  String imageUrl = '';

  @override
  void initState() {
    _nameStoreCntrl = TextEditingController();
    _addressStoreCntrl = TextEditingController();
    _numberPhoneStoreCntrl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameStoreCntrl.dispose();
    _addressStoreCntrl.dispose();
    _numberPhoneStoreCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColor = ColorCustom();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor.bluePrimary,
        title: const Text('Edit Profile Warung'),
        centerTitle: true,
        actions: [
          Consumer<ProfileStoreViewModel>(
            builder: (context, value, child) => IconButton(
              onPressed: () {
                FirebaseAuth authInstance = FirebaseAuth.instance;
                User user = authInstance.currentUser!;

                final data = ProfileStore(
                  id: user.uid,
                  nameStore: _nameStoreCntrl.text,
                  addressStore: _addressStoreCntrl.text,
                  numberStore: _numberPhoneStoreCntrl.text,
                );
                value.addDataProfile(data);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileStoreScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.check_circle_outline_outlined),
            ),
          ),
        ],
      ),
      body: Form(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  StreamBuilder<DocumentSnapshot<Object?>>(
                      stream: Provider.of<ProfileStoreViewModel>(context,
                              listen: false)
                          .getDataImgProfile(),
                      builder: (context, snapshot) {
                        Map<String, dynamic>? data =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        return Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.black),
                            shape: BoxShape.circle,
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
                      }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                      ),
                      margin: const EdgeInsets.only(),
                      child: IconButton(
                        onPressed: () {
                          showModalCustom(context);
                        },
                        icon: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _nameStoreCntrl,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.store),
                            labelText: 'Nama Warung',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _addressStoreCntrl,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.location_on),
                              labelText: 'Alamat',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _numberPhoneStoreCntrl,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              labelText: 'Nomer',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<dynamic> showModalCustom(BuildContext context) {
    Reference refInstance = FirebaseStorage.instance.ref();
    ImagePicker imagePicker = ImagePicker();
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseAuth authInstance = FirebaseAuth.instance;
    User user = authInstance.currentUser!;

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
                  Reference refDirImage = refInstance.child('user');
                  Reference refImageToUpload =
                      refDirImage.child(uniqueFileName);
                  refDirImage.child(uniqueFileName);
                  try {
                    await refImageToUpload.putFile(File(file.path));
                    imageUrl = await refImageToUpload.getDownloadURL();

                    final data = ProfileStore(id: user.uid, imageUrl: imageUrl);
                    if (mounted) {
                      Provider.of<ProfileStoreViewModel>(context, listen: false)
                          .addDataImgProfile(data);
                    }
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
                        content: Text('Gagal upload gambar'),
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
                  Reference refDirImage = refInstance.child('user');
                  Reference refImageToUpload =
                      refDirImage.child(uniqueFileName);
                  try {
                    await refImageToUpload.putFile(File(file.path));
                    imageUrl = await refImageToUpload.getDownloadURL();

                    final data = ProfileStore(id: user.uid, imageUrl: imageUrl);
                    if (mounted) {
                      Provider.of<ProfileStoreViewModel>(context, listen: false)
                          .addDataImgProfile(data);
                    }
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
                        content: Text('Gagal upload gambar'),
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
