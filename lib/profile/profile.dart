import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/bottom_navigation.dart';
import '../exercise/screens/exercise_categories.dart';
import '../home/home.dart';
import '../videos/video_list.dart';

class ProfilePage extends StatelessWidget {
  int _currentIndex = 3;

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
              'kamalzala07@gmail.com',
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
              onTap: () {
                // Perform logout action
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
