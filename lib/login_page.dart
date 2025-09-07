import 'package:final_heart_care/reg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:final_heart_care/home.dart';
import 'package:get/get.dart';
import 'package:final_heart_care/sign_in.dart';
import 'package:final_heart_care/signup_controller.dart';
import 'package:final_heart_care/space.dart';
import 'package:final_heart_care/resetpass.dart';
import 'package:final_heart_care/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  bool _isObsure = false;
  bool pass = true;
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  Color pinki = Colors.pink;
  final AuthService _authService = AuthService();

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red)
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(36),
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Image.asset(
                          "assets/heart1.png",
                          height: 200,
                        ),
                        TextFormField(
                          controller: controller.userEmail,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller.userPass,
                          obscureText: !_isObsure,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObsure = !_isObsure;
                                    });
                                  },
                                  icon: Icon(
                                    _isObsure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  )),
                              prefixIcon: const Icon(Icons.lock_outlined),
                              labelText: "Password",
                              hintText: "Password",
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetPass()));
                              },
                              child: const Text("Forget Password ?")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: controller.userEmail.text.trim(),
                                      password: controller.userPass.text.trim()
                                    );
                                    if (credential.user != null) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomePage()),
                                      );
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      showErrorMessage('No user found for that email.');
                                    } else if (e.code == 'wrong-password') {
                                      showErrorMessage('Wrong password provided.');
                                    } else {
                                      showErrorMessage(e.message ?? 'Authentication failed');
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: const Text("login",
                                  style: TextStyle(color: Colors.white)),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: const Image(
                                image: AssetImage("assets/google.png"),
                              ),
                              label: const Text("Sign in with Google",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              onPressed: () async {
                                try {
                                  final userCredential = await _authService.signInWithGoogle();
                                  if (userCredential?.user != null) {
                                    debugPrint('Google Sign in successful');
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const HomePage()),
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    showErrorMessage('Google Sign In Failed');
                                  }
                                } catch (e) {
                                  debugPrint('Error during Google Sign In: $e');
                                  // showErrorMessage('Error during Google Sign In');
                                }
                              },
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            },
                            child: const Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Don't have a account ? ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(text: " Sign In", style: TextStyle()),
                            ])))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}