import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth for logout
import '../components/appbar.dart';
import '../components/bottom_navigation.dart';
import '../exercise/screens/exercise_categories.dart';
import '../home/home.dart';
import '../videos/video_list.dart';
import '../auth/screens/login.dart'; // Import the login page/screen

class ProfilePage extends StatelessWidget {
  final int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kamal Zala',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'test3@test.com ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              title: Text('Edit Profile'),
              leading: Icon(Icons.edit, color: Colors.orange.shade700),
              onTap: () {
                // Navigate to edit profile screen
              },
            ),
            ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock, color: Colors.orange.shade700),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            Divider(),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout, color: Colors.red),
              onTap: () async {
                // Perform logout action
                await FirebaseAuth.instance.signOut(); // Sign out from Firebase

                // Navigate to the login page after logging out
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(), // Redirect to login page
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseCategories(),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VideosPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
