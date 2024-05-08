import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/exercise_log.dart'; // Importing the log service
import '../../profile/userprovider.dart'; // UserProvider for current user info

class ExerciseMeasurementController {
  final String exerciseName;
  final String category;
  final ExerciseLogService exerciseLogService; // Log service instance
  final UserProvider userProvider; // User provider to get current user info

  int totalSets = 3;
  List<int> setReps = [10, 10, 10];
  List<bool> setCompleted = [false, false, false];
  int currentSet = -1; // No set is initially selected
  bool isLoggingSet = false; // To prevent double-clicking during logging
  int restTimer = 0; // Rest timer in seconds
  Timer? restCountdown; // Timer for the rest countdown
  List<int> selectedSets = []; // Tracks selected sets for logging
  DateTime? workoutStartTime; // Tracks the start time of the workout
  DateTime? workoutEndTime; // Tracks the end time of the workout

  ExerciseMeasurementController({
    required this.exerciseName,
    required this.category,
    required this.exerciseLogService,
    required this.userProvider,
  }) {
    workoutStartTime = DateTime.now(); // Start the workout when the controller is created
  }

  Future<void> logSet(BuildContext context) async {
    if (!isLoggingSet && currentSet != -1 && !setCompleted[currentSet]) {
      isLoggingSet = true; // Start logging

      await Future.delayed(
          Duration(seconds: 2)); // Simulate a delay for logging

      setCompleted[currentSet] = true; // Mark the current set as completed
      isLoggingSet = false; // End the logging process

      if (setCompleted.every((c) => c)) { // If all sets are completed
        workoutEndTime = DateTime.now(); // Record the end time
        showWorkoutSummary(context); // Show the workout summary
      } else {
        restTimer = 60; // Set the rest timer
        startRestTimer(); // Initiate the rest countdown
      }
    }
  }

  void startRestTimer() {
    restCountdown?.cancel(); // Cancel existing timers
    restCountdown = Timer.periodic(Duration(seconds: 1), (timer) {
      if (restTimer > 0) {
        restTimer--; // Decrement the rest timer
      } else {
        timer.cancel(); // Stop the timer when rest ends
      }
    });
  }

  void setCurrentSet(int index) {
    currentSet = index; // Set the current set
  }

  void addSetWithReps(int reps) {
    setReps.add(reps); // Add a new set with the specified reps
    setCompleted.add(false); // Initially not completed
    totalSets++; // Increment total sets
  }

  void addSelectedSet(int index) {
    if (!selectedSets.contains(index)) {
      selectedSets.add(index); // Add the set to selected sets
    }
  }

  void removeSelectedSet(int index) {
    selectedSets.remove(index); // Remove the set from selected sets
  }

  void showWorkoutSummary(BuildContext context) {
    if (workoutStartTime == null || workoutEndTime == null) {
      return; // Ensure the workout times are valid
    }

    final duration = workoutEndTime!.difference(workoutStartTime!);
    final totalSetsCompleted = setCompleted.where((c) => c).length;
    final averageTimePerSet = totalSetsCompleted > 0 ? duration.inSeconds / totalSetsCompleted : 0;

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
              SizedBox(width: 10),
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                Navigator.pop(context); // Navigate back
              },
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }
}
