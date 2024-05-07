import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart'; // For circular progress indicators

class RunningTracker extends StatefulWidget {
  final double goal; // The running goal in meters

  RunningTracker({required this.goal});

  @override
  _RunningTrackerState createState() => _RunningTrackerState();
}

class _RunningTrackerState extends State<RunningTracker> {
  bool isRunning = false;
  bool isPaused = false; // Track pause state
  List<Position> trackPoints = [];
  double totalDistance = 0.0; // Total distance covered in meters
  int runTime = 0; // Running time in seconds
  Timer? runTimer; // Timer for tracking run time

  @override
  Widget build(BuildContext context) {
    double remainingPercentage =
        (1 - (totalDistance / widget.goal)).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Running Tracker"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 12,
              percent: remainingPercentage,
              center: Text(
                "${(remainingPercentage * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
              progressColor: Colors.orange.shade800,
            ),
            SizedBox(height: 20),
            _buildRunDetails(),
            SizedBox(height: 20),
            _buildRunControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildRunDetails() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Distance: ${(totalDistance).toStringAsFixed(2)} m', // Display distance in meters
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Run Time: ${runTime ~/ 60}:${(runTime % 60).toString().padLeft(2, "0")} mins',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRunControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons evenly
      children: [
        ElevatedButton(
          onPressed: isRunning ? _pauseRun : _startRun,
          child: Text(isRunning ? "Pause" : "Start"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (isRunning) // Show "Stop" only when running
          ElevatedButton(
            onPressed: _stopRun,
            child: Text("Stop"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
      ],
    );
  }

  void _startRun() {
    if (!isRunning) {
      setState(() {
        isRunning = true;
        isPaused = false; // Ensure run isn't paused
        totalDistance = 0.0; // Reset distance
        runTime = 0; // Reset running time
        trackPoints.clear(); // Clear previous tracking points
        runTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          runTime++; // Increment running time
          _getCurrentLocation(); // Continuously fetch current location
        });
      });
    } else if (isPaused) {
      setState(() {
        isPaused = false; // Unpause running
        runTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          runTime++; // Increment running time
          _getCurrentLocation(); // Continuously fetch current location
        });
      });
    }
  }

  void _pauseRun() {
    if (isRunning && !isPaused) {
      setState(() {
        isPaused = true; // Pause running
        runTimer?.cancel(); // Stop the timer
      });
    }
  }

  void _stopRun() {
    if (isRunning) {
      _pauseRun(); // Pause running
      _calculateDistance(); // Calculate the distance covered
    }
  }

  void _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      trackPoints.add(position); // Add the current position to track
    }).catchError((e) {
      print("Error getting location: $e");
    });
  }

  void _calculateDistance() {
    double distance = 0.0; // Reset distance
    for (int i = 0; i < trackPoints.length - 1; i++) {
      distance += Geolocator.distanceBetween(
        trackPoints[i].latitude,
        trackPoints[i].longitude,
        trackPoints[i + 1].latitude,
        trackPoints[i + 1].longitude,
      );
    }

    setState(() {
      totalDistance = distance; // Total distance in meters
    });
  }
}
