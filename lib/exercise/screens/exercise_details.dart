import 'package:flutter/material.dart';
import 'exercise_measurement.dart'; // Importing the exercise measurement page
import '../services/exercise_service.dart'; // Central service for fetching exercise data
import '../services/exercise.dart'; // Exercise class
import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';
import '../../videos/video_list.dart';
import '../../home/home.dart';
import '../../profile/profile.dart';
import 'exercise_categories.dart';

class ExerciseDetails extends StatelessWidget {
  final String exerciseName;
  final String category;

  ExerciseDetails({required this.exerciseName, required this.category});

  @override
  Widget build(BuildContext context) {
    final exercise = ExerciseService.getExerciseDetails(category, exerciseName);
    int _currentIndex = 1;

    if (exercise == null) {
      return Scaffold(
        appBar: CustomGradientAppBar(),
        body: Center(
          child: Text("Details for the selected exercise could not be found."),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => _navigateToPage(context, index),
        ),
      );
    }

    return Scaffold(
      appBar: CustomGradientAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exercise image
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  exercise.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Description section
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                exercise.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Steps section
              Text(
                "Steps",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: exercise.steps.map((step) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.orange.shade700),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            step,
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Start Exercise button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseMeasurementView(
                          exerciseName: exercise.name,
                          category: category,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Start Exercise",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // User feedback
              Text(
                "User Feedback",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.green),
                  SizedBox(width: 8),
                  Icon(Icons.thumb_down, color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _navigateToPage(context, index),
      ),
    );
  }

  void _navigateToPage(BuildContext context, int index) {
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
