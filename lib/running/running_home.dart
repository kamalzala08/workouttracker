import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async'; // For Timer functionality
import 'package:percent_indicator/circular_percent_indicator.dart'; // For circular progress indicators

class RunningTracker extends StatefulWidget {
  @override
  _RunningTrackerState createState() => _RunningTrackerState();
}

class _RunningTrackerState extends State<RunningTracker> {
  bool isRunning = false;
  List<Position> trackPoints = [];
  double totalDistance = 0.0; // In kilometers
  int runTime = 0; // In seconds
  Timer? runTimer; // Timer for tracking running time

  @override
  Widget build(BuildContext context) {
    double percentage = (totalDistance / 10.0).clamp(0.0, 1.0); // 10 km target
    return Scaffold(
      appBar: AppBar(
        title: Text("Running Tracker"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: percentage,
                center: Text(
                  "${(percentage * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                progressColor: Colors.orange,
              ),
              SizedBox(height: 20),
              _buildRunDetails(),
              SizedBox(height: 20),
              _buildRunControls(),
              SizedBox(height: 20),
              _buildActivityLog(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRunDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Distance: ${totalDistance.toStringAsFixed(2)} km',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Run Time: ${runTime ~/ 60}:${(runTime % 60).toString().padLeft(2, '0')} mins',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildRunControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(width: 16),
        if (isRunning) // Only show Stop button when running
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

  Widget _buildActivityLog() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Previous Runs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 16),
          for (var run in _generateDummyData()) // Dummy data for the log
            ListTile(
              leading: Icon(Icons.directions_run, color: Colors.orange),
              title: Text(
                '${run.distance.toStringAsFixed(2)} km',
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                'Time: ${run.time.toStringAsFixed(2)} mins, Avg Speed: ${run.avgSpeed.toStringAsFixed(2)} km/h',
              ),
            ),
        ],
      ),
    );
  }

  void _startRun() {
    if (!isRunning) {
      setState(() {
        isRunning = true;
        trackPoints.clear(); // Clear previous run points
        totalDistance = 0.0;
        runTime = 0;
        runTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            runTime++; // Increment running time
          });
        });

        _getCurrentLocation(); // Get the first location
      });
    }
  }

  void _pauseRun() {
    if (isRunning) {
      setState(() {
        isRunning = false;
        runTimer?.cancel(); // Stop the timer
      });
    }
  }

  void _stopRun() {
    if (isRunning) {
      _pauseRun(); // Pause the run
      _calculateDistance(); // Calculate the total distance
    }
  }

  void _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      trackPoints.add(position); // Add position to the track
    }).catchError((e) {
      print("Error getting location: $e");
    });
  }

  void _calculateDistance() {
    double distance = 0.0;
    for (int i = 0; i < trackPoints.length - 1; i++) {
      distance += Geolocator.distanceBetween(
        trackPoints[i].latitude,
        trackPoints[i].longitude,
        trackPoints[i + 1].latitude,
        trackPoints[i + 1].longitude,
      );
    }

    setState(() {
      totalDistance = distance / 1000; // Convert to kilometers
    });
  }

  static List<RunData> _generateDummyData() {
    final List<RunData> data = [];
    for (int i = 0; i < 10; i++) {
      data.add(RunData(
        (i + 1) * 2.5,
        (i + 1) * 10,
        ((i + 1) * 2.5) / ((i + 1) * 10 / 60),
      ));
    }
    return data;
  }
}

class RunData {
  final double distance; // Total distance covered
  final double time; // Total time spent running
  final double avgSpeed; // Average speed

  RunData(this.distance, this.time, this.avgSpeed);
}
