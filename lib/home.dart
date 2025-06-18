import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:final_heart_care/Account.dart';
import 'package:final_heart_care/Detai.dart';
import 'package:final_heart_care/Prediction.dart';
import 'package:final_heart_care/doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  var primary = const Color.fromARGB(255, 227, 14, 53);

  void _handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Detail(onPageChange: _handlePageChange),
      const Doctor_info(),
      const Predict(),
      const Account()
    ];

    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: pages,
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            _handlePageChange(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                activeColor: primary,
                inactiveColor: Colors.black,
                title: const Text('Home'),
                icon: const Icon(Icons.home)),
            BottomNavyBarItem(
                activeColor: primary,
                inactiveColor: Colors.black,
                title: const Text('Doctor'),
                icon: const Icon(Icons.medical_services_rounded)),
            BottomNavyBarItem(
                activeColor: primary,
                inactiveColor: Colors.black,
                title: const Text('Predection'),
                icon: const Icon(Icons.event_note_rounded)),
            BottomNavyBarItem(
              activeColor: primary,
              inactiveColor: Colors.black,
              title: const Text('Account'),
              icon: const Icon(Icons.manage_accounts_rounded),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
