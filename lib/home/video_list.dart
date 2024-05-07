import 'package:flutter/material.dart';

class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Videos'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text('How to Perform a Bench Press'),
            subtitle: Text('Instructional video'),
            onTap: () {
              // Logic to play video or navigate to a video player page
            },
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text('The Perfect Plank'),
            subtitle: Text('Core strengthening exercise'),
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text('Effective Leg Workouts'),
            subtitle: Text('Squats, lunges, and more'),
          ),
          // Add more videos here...
        ],
      ),
    );
  }
}
