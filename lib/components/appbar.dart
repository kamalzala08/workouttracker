import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title; // The title text
  final double elevation; // AppBar elevation

  CustomGradientAppBar({
    this.title = "WorkOut Tracker",
    this.elevation = 4.0, // Default elevation
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade800,
              Colors.orange.shade600
            ], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22, // Specific font size
        ),
      ),
      leading: Icon(
        FontAwesomeIcons.dumbbell, // AppBar leading icon
        color: Colors.white,
      ),
      centerTitle: true, // Ensure the title is centered
      elevation: elevation, // Set the AppBar's elevation
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Default AppBar height
}
