import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:restaurant/login/auth_page.dart';
import 'package:restaurant/login/login.dart';

class SplashModel extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _miBox = Hive.box('miBox');

  localLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _miBox.get('usuario'), password: _miBox.get('clave'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
      }
    }
  }

  void loadView() async {
    await Future.delayed(const Duration(seconds: 3));

    if (_miBox.get('usuario') != null) {
      localLogin;
      Get.to(() => const AuthPage());
    } else {
      Get.to(() => const LogIn());
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
