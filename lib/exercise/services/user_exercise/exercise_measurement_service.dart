import 'package:cloud_firestore/cloud_firestore.dart';

class MeasuredExercise {
  final String uid;
  final String exerciseName;
  final int sets;
  final List<int> reps;

  MeasuredExercise({
    required this.uid,
    required this.exerciseName,
    required this.sets,
    required this.reps,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'exerciseName': exerciseName,
      'sets': sets,
      'reps': reps,
    };
  }
}

class ExerciseMeasurementService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'user_exercises';

  Future<void> addMeasuredExercise(MeasuredExercise exercise) async {
    try {
      await _firestore.collection(collectionName).add(exercise.toMap());
    } catch (e) {
      print('Error adding measured exercise: $e');
      throw e; // Propagate the error for handling in UI if needed
    }
  }

  Future<List<MeasuredExercise>> getMeasuredExercises(String uid) async {
    try {
      final querySnapshot = await _firestore
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .get();

      return querySnapshot.docs.map((doc) {
        return MeasuredExercise(
          uid: doc['uid'],
          exerciseName: doc['exerciseName'],
          sets: doc['sets'],
          reps: List<int>.from(doc['reps']),
        );
      }).toList();
    } catch (e) {
      print('Error getting measured exercises: $e');
      throw e; // Propagate the error for handling in UI if needed
    }
  }
}
