import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.orange.shade700,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.dumbbell),
          label: 'Exercises',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.video),
          label: 'Videos',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: 'Profile',
        ),
      ],
    );
  }
}
