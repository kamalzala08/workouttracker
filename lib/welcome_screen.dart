import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String userEmail; // The user's email passed from the login screen

  const WelcomeScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text(
          'Hello, welcome $userEmail', // Display the welcome message with the email
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
