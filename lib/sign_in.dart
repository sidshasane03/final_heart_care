import 'package:final_heart_care/home.dart';
import 'package:final_heart_care/login_page.dart';
import 'package:final_heart_care/reg.dart';
import 'package:final_heart_care/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  bool _isObsure = true;
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

  RegExp Reqpass = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String passord) {
    String pass = passord.trim();
    if (Reqpass.hasMatch(pass)) {
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
                    child: Column(
                      children: [
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
                              return "Please Enter UserName";
                            } else {
                              return null;
                            }
                          },
                          controller: controller.userName,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: "UserName",
                              hintText: "Full Name",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value2) {
                            formKey.currentState!.validate();
                          },
                          validator: (value2) {
                            if (value2!.isEmpty) {
                              return "Please Enter Email Address";
                            } else {
                              bool resEmail = validateEmail(value2);
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
                        TextFormField(
                          onChanged: (value3) {
                            formKey.currentState!.validate();
                          },
                          validator: (value3) {
                            if (value3!.isEmpty) {
                              return "Please Enter Mobile No";
                            } else {
                              return null;
                            }
                          },
                          controller: controller.phoneNo,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.phone_android_outlined),
                              labelText: "Phone no",
                              hintText: "Phone Number",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value4) {
                            formKey.currentState!.validate();
                          },
                          validator: (value4) {
                            if (value4!.isEmpty) {
                              return "Please Enter Password";
                            } else {
                              bool respass = validatePassword(value4);
                              if (respass) {
                                return null;
                              } else {
                                return 'Password must contain special,\nNumber & Capital character';
                              }
                            }
                          },
                          obscureText: pass ? !_isObsure : false,
                          controller: controller.userPass,
                          decoration: InputDecoration(
                              suffixIcon: pass
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isObsure = !_isObsure;
                                        });
                                      },
                                      icon: Icon(
                                        _isObsure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ))
                                  : null,
                              prefixIcon: const Icon(Icons.lock_outlined),
                              labelText: "Password",
                              hintText: "Password",
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SignUpController.instance.registerUser(
                                      controller.userEmail.text.trim(),
                                      controller.userPass.text.trim(),
                                      controller.userName.text.trim(),
                                      controller.phoneNo.text.trim());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: const Text("Sign up",
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
                              onPressed: () {
                                signInWithGoogle().then((result) {
                                  if (result != null) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return const HomePage();
                                      },
                                    ));
                                  }
                                });
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
                                          const login_page()));
                            },
                            child: const Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "Already have a account ? ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(text: " login", style: TextStyle()),
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
