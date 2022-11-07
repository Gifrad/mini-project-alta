import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/user_register.dart';
import '../../../utils/utils.dart';
import '../../../view_model/auth.dart';
import '../../login/login_screen.dart';

class FormCardRegister extends StatefulWidget {
  const FormCardRegister({super.key});

  @override
  State<FormCardRegister> createState() => _FormCardRegisterState();
}

class _FormCardRegisterState extends State<FormCardRegister> {
  final colorCustom = ColorCustom();
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: colorCustom.greenPrimary,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: colorCustom.greenPrimary, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: colorCustom.greenPrimary, width: 3.0),
                    ),
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value != null && value.length < 3) {
                      return 'Masukan minimal 3 karakter';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: colorCustom.greenPrimary,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: colorCustom.greenPrimary, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: colorCustom.greenPrimary, width: 3.0),
                    ),
                    labelText: 'Email',
                  ),
                  validator: (email) {
                    if (email != null && !EmailValidator.validate(email)) {
                      return 'Masukan Email dengan benar';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                //password
                Consumer<AuthViewModel>(
                  builder: (context, value, child) => TextFormField(
                    obscureText: value.isTrue,
                    controller: _passController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.toggleObs();
                        },
                        icon: value.switchObsIconRegister,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: colorCustom.greenPrimary,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: colorCustom.greenPrimary, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: colorCustom.greenPrimary, width: 3.0),
                      ),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value != null && value.length <= 5) {
                        return 'Masukan min. 6 karakter';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width * 0.3,
                  child: Consumer<AuthViewModel>(
                    builder: (context, value, child) {
                      if (value.state == ViewState.loading) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: colorCustom.bluePrimary,
                            color: colorCustom.greenPrimary,
                          ),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorCustom.greenPrimary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.all(
                                20) //content padding inside button
                            ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            final result = await value.signUp(
                              UserRegisterModel(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passController.text),
                            );

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result.toString()),
                                ),
                              );
                            }
                          }
                          validateUser();
                        },
                        child: Text(
                          'Daftar',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateUser() {
    FirebaseAuth resultUser = FirebaseAuth.instance;
    resultUser.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          return;
        } else {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          }
        }
      },
    );
  }
}
