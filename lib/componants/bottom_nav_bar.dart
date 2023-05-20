import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: Colors.lightGreen[700],
        color: Colors.lightGreen[300],
        tabActiveBorder: Border.all(color: Colors.lightGreen),
        gap: 8,
        tabs: const [
          /// Home tab
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          /// About tab
          GButton(
            icon: Icons.info,
            text: 'About',
          ),
        ],
      ),
    );
  }
}