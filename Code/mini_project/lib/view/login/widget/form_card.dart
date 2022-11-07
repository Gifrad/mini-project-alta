import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/user_login.dart';
import '../../../utils/utils.dart';
import '../../../view_model/auth.dart';
import '../../../view_model/customer.dart';

class FormCard extends StatefulWidget {
  const FormCard({super.key});

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  final colorCustom = ColorCustom();
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

//Dispose Controller
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: colorCustom.bluePrimary,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: colorCustom.bluePrimary, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: colorCustom.bluePrimary, width: 3.0),
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
                        icon: value.switchObsIcon,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: colorCustom.bluePrimary,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: colorCustom.bluePrimary, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: colorCustom.bluePrimary, width: 3.0),
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
                            backgroundColor: colorCustom.bluePrimary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.all(
                                20) //content padding inside button
                            ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            final result = await value.login(
                              UserLoginModel(
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
                            if (mounted) {}
                            context
                                .read<CustomerViewModel>()
                                .dataCustomer
                                .clear();
                          }
                        },
                        child: Text(
                          'Masuk',
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
}
