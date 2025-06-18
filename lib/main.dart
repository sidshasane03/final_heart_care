import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_heart_care/authentication_repository.dart';
import 'package:final_heart_care/home.dart';
import 'package:final_heart_care/we.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthenticationRepository());
  runApp(const MyApp(showHome: true));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({
    super.key,
    required this.showHome,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HeartCare',
      debugShowCheckedModeBanner: false,
      home: showHome ? const Wellcome() : const HomePage(),
    );
  }
}

class onboardpage extends StatefulWidget {
  const onboardpage({super.key});

  @override
  State<onboardpage> createState() => _onboardpageState();
}

class _onboardpageState extends State<onboardpage> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: 250,
            ),
            const SizedBox(height: 64),
            Text(
              title,
              style: TextStyle(
                  color: Colors.pink.shade600,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: Color.fromARGB(255, 239, 20, 126),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                  color: Colors.white,
                  urlImage: "assets/heart3.png",
                  title: "Medicine Advice",
                  subtitle: "Early Medicine and precaution has been given"),
              buildPage(
                  color: Colors.white,
                  urlImage: "assets/heart1.png",
                  title: "Speacialits",
                  subtitle: "Advice of Best Doctors"),
              buildPage(
                  color: Colors.white,
                  urlImage: "assets/heart.png",
                  title: "Heart-Disease Free World ",
                  subtitle: "We have to make this world Heart-Disease free"),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                onPressed: () async {
                  //navigat to home page
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("showHome", true);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const Wellcome())));
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    // primary: Colors.white,
                    backgroundColor: Colors.pink.shade700,
                    minimumSize: const Size.fromHeight(80)),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 24),
                ))
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => controller.jumpToPage(2),
                        child: const Text("Skip")),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const WormEffect(
                            spacing: 15,
                            dotColor: Colors.black26,
                            activeDotColor: Colors.pink),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                        onPressed: () => {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut)
                            },
                        child: const Text("Next"))
                  ],
                ),
              ),
      );
}
