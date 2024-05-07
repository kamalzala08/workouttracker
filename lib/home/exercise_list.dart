import 'package:flutter/material.dart';

class ExerciseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Bicep Curls'),
            subtitle: Text('3 sets of 12 reps'),
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Shoulder Press'),
            subtitle: Text('3 sets of 10 reps'),
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Squats'),
            subtitle: Text('4 sets of 8 reps'),
          ),
          // Add more exercises here...
        ],
      ),
    );
  }
}
