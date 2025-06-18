import 'package:final_heart_care/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userEmail = TextEditingController();
  final userPass = TextEditingController();
  final userName = TextEditingController();
  final phoneNo = TextEditingController();

  // Call this function from Design & it will do the rest
  void registerUser(
      String userEmail, String userPass, String userName, String phoneNo) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(userEmail, userPass, userName, phoneNo);
  }

  void login(String userEmail, String userPass) async {
    AuthenticationRepository.instance
        .signInWithEmailAndPassword(userEmail, userPass);
  }

  void signInWithGoogle() async {
    AuthenticationRepository.instance.signInWithGoogle();
  }
}
