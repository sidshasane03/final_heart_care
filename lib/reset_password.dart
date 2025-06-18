import 'package:final_heart_care/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  final bool _isObsure = true;
  bool pass = true;
  RegExp Reqemail = RegExp(r"(?=.*[a-z])");
  bool validateEmail(String email) {
    String Email = email.trim();
    if (Reqemail.hasMatch(Email)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(36),
                child: Column(
                  children: [
                    Form(
                        key: formKey,
                        child: Column(children: [
                          Image.asset(
                            "assets/heart.png",
                            height: 200,
                          ),
                          TextFormField(
                            onChanged: (value1) {
                              formKey.currentState!.validate();
                            },
                            validator: (value1) {
                              if (value1!.isEmpty) {
                                return "Please Enter Email Address";
                              } else {
                                bool resEmail = validateEmail(value1);
                                if (resEmail) {
                                  return null;
                                } else {
                                  return 'Email must contain special character';
                                }
                              }
                            },
                            controller: controller.userEmail,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                labelText: "Email",
                                hintText: "Email",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                child: const Text("Reset Password"),
                              )),
                        ]))
                  ],
                ))),
      ),
    );
  }
}
