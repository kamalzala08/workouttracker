import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'home/home.dart';
import 'package:workouttracker/auth/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase initialization
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkOutTracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
