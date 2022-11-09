import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/models/user_login.dart';
import 'package:mini_project/utils/utils.dart';

import '../models/user_register.dart';

class AuthViewModel extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _isTrue = true;
  bool get isTrue => _isTrue;

  get switchObsIcon {
    return _isTrue
        ? Icon(
            Icons.visibility_off,
            color: ColorCustom().bluePrimary,
          )
        : Icon(
            Icons.visibility,
            color: ColorCustom().bluePrimary,
          );
  }

  get switchObsIconRegister {
    return _isTrue
        ? Icon(
            Icons.visibility_off,
            color: ColorCustom().greenPrimary,
          )
        : Icon(
            Icons.visibility,
            color: ColorCustom().greenPrimary,
          );
  }


  void toggleObs() {
    _isTrue = !_isTrue;
    notifyListeners();
  }

  ViewState _state = ViewState.none;
  ViewState get state => _state;

  changeState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<String> login(UserLoginModel user) async {
    changeState(ViewState.loading);
    late String message = 'Gagal Login, Email dan Password tidak ditemukan!';
    try {
      await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      notifyListeners();
      changeState(ViewState.none);
      return message = 'Berhasil Login';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        changeState(ViewState.none);
        return message = 'Email tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        changeState(ViewState.none);
        return message = 'Password Salah!';
      }
    }
    changeState(ViewState.none);
    return message;
  }

  Future<String> signUp(UserRegisterModel user) async {
    changeState(ViewState.loading);
    late String message = 'Gagal mendaftar, Mohon isi dengan benar!';
    try {
      await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await auth.currentUser!.updateDisplayName(user.name);

      notifyListeners();
      changeState(ViewState.none);
      return message = 'Berhasil Mendaftar';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        changeState(ViewState.none);
        return message = 'Password terlalu lemah';
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
        changeState(ViewState.none);
        return message = 'Gagal , Email telah terdaftar';
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        changeState(ViewState.none);
        return message = e.toString();
      }
    }
    changeState(ViewState.none);
    return message;
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      notifyListeners();
      changeState(ViewState.none);
    } catch (e) {
      changeState(ViewState.none);
    }
  }
}
