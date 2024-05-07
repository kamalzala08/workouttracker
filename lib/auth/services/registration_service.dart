import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  // Register a new user with email, password, and additional information
  Future<void> registerWithEmailAndPassword(String email, String password, String name, String dob, String? gender) async {
    try {
      // Register the user with Firebase Authentication
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's UID from the authentication result
      final String uid = userCredential.user!.uid;

      // Add document to 'users' collection (will create if it doesn't exist)
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'dob': dob,
        'gender': gender ?? 'N/A', // Default to 'N/A' if gender is not provided
      });
    } catch (e) {
      // Handle registration errors
      print('Error during user registration: $e');
      throw e; // Rethrow the error for the caller to handle
    }
  }
}
