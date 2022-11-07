import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/view/splash_screen/splash_screen.dart';
import 'package:mini_project/view_model/auth.dart';
import 'package:mini_project/view_model/customer.dart';
import 'package:mini_project/view_model/profile_store.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => CustomerViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileStoreViewModel()),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Hutang Warung',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplahScreen(),
    );
  }
}
