import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../exercise/screen/exercise_categories.dart'; // Page for exercise list
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

  final List<Widget> _pages = [
    HomeTab(), // Custom widget for Home tab content
    ExerciseCategories(), // Exercise list
    VideoList(), // Exercise videos
    Profile(), // User profile
  ];

  @override
  Widget build(BuildContext context) {
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
      body: _pages[_currentIndex], // Display the corresponding page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;

            if (index == 1) {
              // If the user clicks on "Exercises", redirect to the Exercise page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisePage(), // Redirect to the new page
                ),
              );
            }
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
}

class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"), // New AppBar for this screen
      ),
      body: ExerciseCategories(), // The Exercise content
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String todayDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(todayDate),
            SizedBox(height: 16),
            _buildTrackerSection(context),
            SizedBox(height: 24),
            _buildRecentExercises(),
          ],
        ),
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
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.calendarDay,
              color: Colors.orange.shade700,
            ),
            SizedBox(width: 8),
            Text(
              todayDate,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackerSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildElevatedTrackerBox("Weight", "70 kg", FontAwesomeIcons.dumbbell, context),
        _buildElevatedTrackerBox("Height", "180 cm", FontAwesomeIcons.ruler, context),
        _buildElevatedTrackerBox(
          "BMI",
          "21.6",
          FontAwesomeIcons.scaleUnbalanced, context,
        ),
      ],
    );
  }

  Widget _buildElevatedTrackerBox(
      String name,
      String value,
      IconData icon,
      BuildContext context,
      [VoidCallback? onTap]
      ) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeightPage(), // Navigate to WeightPage
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
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
          children:
          [
            FaIcon(
              icon,
              color: Colors.orange.shade700,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              name,
              style:
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
            Text(
              value,
              style:
              TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentExercises() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
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
          "Bench Press",
          "3 sets of 10 reps",
          FontAwesomeIcons.dumbbell,
        ),
        _buildExerciseTile("Chest Fly", "3 sets of 12 reps", FontAwesomeIcons.handHoldingHeart),
        _buildExerciseTile("Push-Ups", "4 sets of 15 reps", FontAwesomeIcons.hands),
        _buildExerciseTile("Incline Bench Press", "3 sets of 10 reps", FontAwesomeIcons.longArrowAltUp),
        _buildExerciseTile("Decline Bench Press", "3 sets of 10 reps", FontAwesomeIcons.longArrowAltDown),
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
        style:
        TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.orange.shade700,
        ),
      ),
      subtitle:
      Text(
        subtitle,
        style:
        TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
