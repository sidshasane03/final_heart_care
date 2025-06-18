import 'package:final_heart_care/home.dart';
import 'package:final_heart_care/sign_in.dart';
import 'package:final_heart_care/we.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const Wellcome(),
    '/sign-in': (context) => const SignInPage(),
    '/home': (context) => const HomePage()
  };
}
