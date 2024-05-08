import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../videos/video_list.dart';
import '../weight/weight_page.dart';
import '../height/height_page.dart';
import '../components/appbar.dart';
import '../components/bottom_navigation.dart';
import '../exercise/screens/exercise_categories.dart';
import '../profile/profile.dart';
import '../profile/user.dart';
import '../profile/userprovider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final String todayDate = DateFormat.yMMMMd().format(DateTime.now());

    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: CustomGradientAppBar(),
        body: HomePageContent(),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _navigateToScreen(index);
          },
        ),
      ),
    );
  }

  void _navigateToScreen(int index) {
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
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
        break;
    }
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String todayDate = DateFormat.yMMMMd().format(DateTime.now());
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(todayDate, currentUser),
          SizedBox(height: 16),
          _buildTrackerSection(context),
          SizedBox(height: 24),
          _buildRecentExercises(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(String todayDate, User? currentUser) {
    final userName = currentUser != null ? currentUser.name : 'Guest';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $userName',
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
        _buildElevatedTrackerBox("Weight", "70 kg", FontAwesomeIcons.dumbbell,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeightPage(),
                ),
              );
            }),
        _buildElevatedTrackerBox("Height", "180 cm", FontAwesomeIcons.ruler,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HeightPage(),
                ),
              );
            }),
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(icon, color: Colors.orange.shade700, size: 32),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700,
              ),
            ),
            Text(
              value,
              style: TextStyle(
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
          "Bench Press",
          "3 sets of 10 reps",
          FontAwesomeIcons.dumbbell,
        ),
        _buildExerciseTile(
          "Chest Fly",
          "3 sets of 12 reps",
          FontAwesomeIcons.handHoldingHeart,
        ),
        _buildExerciseTile(
          "Push-Ups",
          "4 sets of 15 reps",
          FontAwesomeIcons.hands,
        ),
        _buildExerciseTile(
          "Incline Bench Press",
          "3 sets of 10 reps",
          FontAwesomeIcons.longArrowAltUp,
        ),
        _buildExerciseTile(
          "Decline Bench Press",
          "3 sets of 10 reps",
          FontAwesomeIcons.longArrowAltDown,
        ),
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
