import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workouttracker/auth/screens/login.dart';
// import 'package:workouttracker/auth/registration.dart';
// import 'package:workouttracker/auth/forget_password.dart';
// import 'package:workouttracker/auth/test.dart';
import 'package:workouttracker/home/home.dart';
import 'package:workouttracker/weight/weight_page.dart';
// import 'package:workouttracker/exercise/exercise_categories.dart';
import 'package:workouttracker/exercise/screen/exercise_categories.dart';
//cj Test
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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
