import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/utils/utils.dart';
import 'package:mini_project/view/home/home_screen.dart';
import 'package:mini_project/view/login/login_screen.dart';
import 'package:mini_project/view/profile_store/edit_profile_screen.dart';
import 'package:mini_project/view_model/auth.dart';
import 'package:mini_project/view_model/customer.dart';
import 'package:mini_project/view_model/profile_store.dart';
import 'package:provider/provider.dart';

class ProfileStoreScreen extends StatefulWidget {
  const ProfileStoreScreen({super.key});

  @override
  State<ProfileStoreScreen> createState() => _ProfileStoreScreenState();
}

class _ProfileStoreScreenState extends State<ProfileStoreScreen> {
  @override
  Widget build(BuildContext context) {
    final customColor = ColorCustom();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor.bluePrimary,
        leading: IconButton(
            onPressed: () {
              Provider.of<CustomerViewModel>(context, listen: false)
                  .dataCustomer
                  .clear();
              Navigator.pushReplacement(
                context,
                TransitionScreen(
                  beginLeft: 0.0,
                  beginRight: 1.0,
                  curvesAction: Curves.easeInBack,
                  screen: const HomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Profile Warung'),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot<Object?>>(
                stream:
                    Provider.of<ProfileStoreViewModel>(context, listen: false)
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
            const SizedBox(height: 8),
            StreamBuilder<DocumentSnapshot<Object?>>(
                stream:
                    Provider.of<ProfileStoreViewModel>(context, listen: false)
                        .getDataProfile(),
                builder: (context, snapshot) {
                  Map<String, dynamic>? data =
                      snapshot.data?.data() as Map<String, dynamic>?;

                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            backgroundColor: customColor.greenPrimary,
                            radius: 20,
                            child: Icon(
                              Icons.person,
                              color: customColor.bluePrimary,
                            )),
                        title: const Text("Nama Warung"),
                        subtitle: data?['nameStore'] != null
                            ? Text('${data?['nameStore']}')
                            : const Text('N/A'),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: CircleAvatar(
                            backgroundColor: customColor.greenPrimary,
                            radius: 20,
                            child: Icon(
                              Icons.location_city,
                              color: customColor.bluePrimary,
                            )),
                        title: const Text("Alamat Warung"),
                        subtitle: data?['addressStore'] != null
                            ? Text('${data?['addressStore']}')
                            : const Text('N/A'),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: CircleAvatar(
                            backgroundColor: customColor.greenPrimary,
                            radius: 20,
                            child: Icon(
                              Icons.phone,
                              color: customColor.bluePrimary,
                            )),
                        title: const Text("No Hp"),
                        subtitle: data?['numberStore'] != null
                            ? Text('${data?['numberStore']}')
                            : const Text('N/A'),
                      ),
                    ],
                  );
                }),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: customColor.greenPrimary),
                    onPressed: () {
                      Navigator.push(
                        context,
                        TransitionScreen(
                          beginLeft: 1.0,
                          beginRight: 0.0,
                          curvesAction: Curves.easeIn,
                          screen: const EditProfileScreen(),
                        ),
                      );
                    },
                    child: const Text('Edit Profile'),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900),
                    onPressed: () {
                      final custViewModel = Provider.of<CustomerViewModel>(
                          context,
                          listen: false);
                      custViewModel.dataCustomer.clear();
                      final authViewModel =
                          Provider.of<AuthViewModel>(context, listen: false);
                      authViewModel.logout().then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            ),
                          );
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
