import 'package:flutter/material.dart';
import 'exercise_measurement.dart'; // Importing the exercise measurement page
import '../services/exercise_service.dart'; // Central service for fetching exercise data
import '../services/exercise.dart'; // Exercise class
// import '../controllers/exercise_measurement_controller.dart';

class ExerciseDetails extends StatelessWidget {
  final String exerciseName;
  final String category; // Category of the exercise

  ExerciseDetails({required this.exerciseName, required this.category});

  @override
  Widget build(BuildContext context) {
    // Fetch specific exercise details using the ExerciseService
    final exercise = ExerciseService.getExerciseDetails(category, exerciseName);

    if (exercise == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Exercise Not Found"),
          backgroundColor: Colors.orange.shade700,
          centerTitle: true,
        ),
        body: Center(
          child: Text("Details for the selected exercise could not be found."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade700, Colors.orange.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  exercise.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
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
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
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
    );
  }
}
