import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:final_heart_care/Account.dart';
import 'package:final_heart_care/Prediction.dart';
import 'package:final_heart_care/authentication_repository.dart';
import 'package:final_heart_care/home.dart';
import 'package:final_heart_care/ai_bot/heart_ai_chat.dart';

class Detail extends StatefulWidget {
  final Function(int) onPageChange; // Add this line
  const Detail({super.key, required this.onPageChange}); // Update constructor

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("HeartCare"),
          actions: [
            IconButton(
                onPressed: () {
                  AuthenticationRepository.instance.signOutGoogle();
                },
                icon: const Icon(Icons.logout_outlined))
          ],
          leading: const Icon(Icons.health_and_safety),
          elevation: 10,
          backgroundColor: Colors.pink,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 40),
            Image.asset(
              "assets/heart3.png",
              height: 120,
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '"We are going to detect the Heart-Disease,and make our country free from Heart-Disease"',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Heart disease is a type of condition that affects the heart's ability to function properly. Your heart is a vital organ in your chest that pumps blood throughout your body. Heart disease is one of the leading causes of death worldwide. Your heart is a vital organ in your chest that pumps blood throughout your body. Heart disease is one of the leading causes of death worldwide.",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
                height: 59,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onPageChange(
                        2); 
                  },
                  style: ElevatedButton.styleFrom(
                      // primary: Colors.pink,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text("Start Predict"),
                )),
          ]),
        ),
        floatingActionButton: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HeartAIChat()),
                  );
                },
                backgroundColor: Colors.pink,
                icon: const Icon(Icons.favorite, color: Colors.white),
                label: const Text('AI Assistant', style: TextStyle(color: Colors.white)),
              ),
            );
          },
        ));
  }
}
