import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExerciseMeasurementController {
  final String exerciseName;
  final String category;

  bool isRunning = false;
  Timer? runTimer;
  int totalSets = 3;
  List<int> setReps = [10, 10, 10];
  List<bool> setCompleted = [false, false, false];
  int currentSet = -1; // No set is initially selected
  bool isLoggingSet = false;
  int restTimer = 0; // Rest timer in seconds
  Timer? restCountdown; // Timer for break/transition
  DateTime? workoutStartTime; // Track workout start time
  DateTime? workoutEndTime; // Track workout end time

  ExerciseMeasurementController({
    required this.exerciseName,
    required this.category,
  });

  void startRestTimer() {
    restCountdown?.cancel(); // Ensure any existing timer is canceled

    restCountdown = Timer.periodic(Duration(seconds: 1), (timer) {
      if (restTimer > 0) {
        restTimer--;
      } else {
        timer.cancel(); // Stop timer when rest is complete
      }
    });
  }

  void editReps(BuildContext context, int index) {
    if (setCompleted[index]) {
      return; // Don't allow editing for completed sets
    }

    TextEditingController repsController = TextEditingController(
      text: setReps[index].toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Reps for Set ${index + 1}"),
          content: TextField(
            controller: repsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter the number of reps",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int? newReps = int.tryParse(repsController.text);
                if (newReps != null) {
                  setReps[index] = newReps;
                  // Call setState in the parent widget to update the UI
                  (context as Element).markNeedsBuild(); // Force a rebuild
                }
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), // Close without saving
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> logSet(BuildContext context) async {
    if (!isLoggingSet && currentSet != -1 && !setCompleted[currentSet]) {
      isLoggingSet = true; // Mark logging as active

      await Future.delayed(
          Duration(seconds: 2)); // Simulate a delay for logging

      setCompleted[currentSet] = true; // Complete the current set
      isLoggingSet = false; // Logging is done

      if (setCompleted.every((c) => c)) {
        // If all sets are completed
        workoutEndTime = DateTime.now(); // Record the end time
        showWorkoutSummary(context); // Show workout summary
      } else {
        restTimer = 60; // Start the rest timer
        startRestTimer(); // Initiate the rest timer
      }
    }
  }

  void setCurrentSet(int index) {
    currentSet = index; // Set the current set index
  }

  void showWorkoutSummary(BuildContext context) {
    if (workoutStartTime == null || workoutEndTime == null) {
      return; // Ensure workout times are valid
    }

    final duration = workoutEndTime!.difference(workoutStartTime!);
    final totalSetsCompleted = setCompleted.where((c) => c).length;
    final averageTimePerSet =
        totalSetsCompleted > 0 ? duration.inSeconds / totalSetsCompleted : 0;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(
                FontAwesomeIcons.trophy,
                color: Colors.orange.shade700,
              ),
              SizedBox(width: 10), // Fixes the missing width space
              Text("Workout Summary"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.dumbbell,
                    color: Colors.orange.shade700,
                  ),
                  SizedBox(width: 10),
                  Text("Total Sets: $totalSets"),
                ],
              ),
              SizedBox(height: 10), // Corrected spacing
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.check,
                    color: Colors.green.shade700,
                  ),
                  SizedBox(width: 10),
                  Text("Sets Completed: $totalSetsCompleted"),
                ],
              ),
              SizedBox(height: 10), // Corrected spacing
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.clock,
                    color: Colors.blue.shade700,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Total Duration: ${duration.inMinutes} minutes and ${duration.inSeconds % 60} seconds",
                  ),
                ],
              ),
              SizedBox(height: 10), // Corrected spacing
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.stopwatch,
                    color: Colors.purple.shade700,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Average Time per Set: ${averageTimePerSet.toStringAsFixed(2)} seconds",
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }
}
