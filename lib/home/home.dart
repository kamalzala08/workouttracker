import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'exercise_list.dart'; // Page for exercise list
import 'video_list.dart'; // Page for exercise videos
import 'profile.dart'; // Page for user profile
import '../weight/weight_page.dart'; // Page for tracking weight
import 'package:intl/intl.dart'; // To format date

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current tab index

  @override
  Widget build(BuildContext context) {
    final String todayDate =
    DateFormat.yMMMMd().format(DateTime.now()); // Get today's date

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade800, Colors.orange.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'WorkoutTracker',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          textAlign: TextAlign.center, // Center the text
        ),
        leading:
        Icon(FontAwesomeIcons.dumbbell, color: Colors.white), // AppBar icon
        centerTitle: true, // Ensure title is centered
        elevation: 4,
      ),
      body: Scrollbar(
        // Adding a scrollbar to improve scroll visibility
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(
                  todayDate), // Welcome message and today's date
              SizedBox(height: 16),
              _buildTrackerSection(), // Tracker section with adjustments
              SizedBox(height: 24),
              _buildRecentExercises(), // Display recent exercises
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Change the tab when clicked
          });
        },
        selectedItemColor: Colors.orange.shade700, // Selected tab color
        unselectedItemColor: Colors.grey, // Unselected tab color
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home', // Home page
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.dumbbell),
            label: 'Exercises', // Exercise page
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.video),
            label: 'Videos', // Videos page
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user), // Profile page
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(String todayDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Kamal Zala',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
            letterSpacing: 1.5, // Slight letter spacing
          ),
        ), // Welcome message
        SizedBox(height: 8), // Small spacing
        Row(
          children: [
            Icon(FontAwesomeIcons.calendarDay,
                color: Colors.orange.shade700), // Date icon
            SizedBox(width: 8),
            Text(
              todayDate,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ), // Display today's date
      ],
    );
  }

  Widget _buildTrackerSection() {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceEvenly, // Evenly distribute items
      children: [
        _buildElevatedTrackerBox("Weight", "70 kg", FontAwesomeIcons.dumbbell,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeightPage(), // Navigate to WeightPage
                ),
              );
            }), // Elevated tracker box for weight
        _buildElevatedTrackerBox("Height", "180 cm", FontAwesomeIcons.ruler),
        _buildElevatedTrackerBox(
            "BMI", "21.6", FontAwesomeIcons.scaleUnbalanced),
      ],
    );
  }

  Widget _buildElevatedTrackerBox(String name, String value, IconData icon,
      [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16), // Consistent padding for elevation
        decoration: BoxDecoration(
          color: Colors.orange.shade50, // Light orange background
          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // Light shadow for elevation
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(icon,
                color: Colors.orange.shade700, size: 32), // Larger icon
            SizedBox(height: 8), // Spacing
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ), // Tracker name
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ), // Tracker value
          ],
        ),
      ),
    );
  }

  Widget _buildRecentExercises() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Exercises',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
          ),
        ),
        SizedBox(height: 16),
        _buildExerciseTile(
            "Bench Press", "3 sets of 10 reps", FontAwesomeIcons.dumbbell),
        _buildExerciseTile("Chest Fly", "3 sets of 12 reps",
            FontAwesomeIcons.handHoldingHeart),
        _buildExerciseTile(
            "Push-Ups", "4 sets of 15 reps", FontAwesomeIcons.hands),
        _buildExerciseTile("Incline Bench Press", "3 sets of 10 reps",
            FontAwesomeIcons.longArrowAltUp),
        _buildExerciseTile("Decline Bench Press", "3 sets of 10 reps",
            FontAwesomeIcons.longArrowAltDown),
      ],
    );
  }

  Widget _buildExerciseTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: FaIcon(
        icon,
        color: Colors.orange.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.orange.shade700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
