import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/profile_pic.png'), // Example image
              backgroundColor: Colors.grey.shade200,
            ),
            SizedBox(height: 20),
            Text(
              'John Doe', // Example user name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Fitness Enthusiast',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic for editing profile or other actions
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
