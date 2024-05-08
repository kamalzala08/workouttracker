import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExerciseLogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add an exercise log for a specific user
  Future<void> addExerciseLog({
    required String userUID,
    required String exerciseName,
    required String category,
    required List<Map<String, dynamic>> sets,
    required DateTime timestamp,
  }) async {
    if (userUID.isEmpty) {
      throw Exception("User ID is required to add an exercise log.");
    }

    final newLog = {
      "exerciseName": exerciseName,
      "category": category,
      "sets": sets,
      "timestamp": timestamp,
    };

    await _firestore.collection("exercises_log").doc(userUID).set(
      {"logs": FieldValue.arrayUnion([newLog])},
      SetOptions(merge: true), // If document exists, merge with existing data
    );
  }

  // Get all exercise logs for a specific user
  Future<List<Map<String, dynamic>>> getExerciseLogs(String userUID) async {
    if (userUID.isEmpty) {
      throw Exception("User ID is required to fetch exercise logs.");
    }

    final docSnapshot = await _firestore.collection("exercises_log").doc(userUID).get();

    if (!docSnapshot.exists) {
      return []; // No logs for this user
    }

    final data = docSnapshot.data();
    if (data == null || !data.containsKey("logs")) {
      return [];
    }

    return List<Map<String, dynamic>>.from(data["logs"]);
  }
}
