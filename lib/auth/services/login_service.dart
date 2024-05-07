import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication instance
  final CollectionReference _loginAttemptsCollection =
  FirebaseFirestore.instance.collection('login_attempts'); // Firestore collection for tracking login attempts

  // Email/password login with escalating lockout periods
  Future<User?> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      final docRef = _loginAttemptsCollection.doc(email);
      final doc = await docRef.get();

      int attemptCount = 0;
      bool isLocked = false;
      DateTime? lockoutEnd;

      if (doc.exists) {
        attemptCount = doc['attempt_count'] ?? 0;
        isLocked = doc['is_locked'] ?? false;
        DateTime? lastFailedLogin = doc['last_failed_login']?.toDate();

        if (lastFailedLogin != null) {
          final lockoutDuration = 5; // Lockout for 5 minutes
          lockoutEnd = lastFailedLogin.add(Duration(minutes: lockoutDuration));

          if (isLocked && DateTime.now().isBefore(lockoutEnd)) { // If lockout is in effect
            final remainingTime = lockoutEnd.difference(DateTime.now()).inMinutes;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Account is locked. Try again in $remainingTime minutes.")),
            );
            return null; // Exit early if account is still locked
          }
        }
      }

      // If account is not locked, attempt to sign in
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Reset attempt count and unlock the account upon successful login
      await docRef.set({
        'last_successful_login': FieldValue.serverTimestamp(), // Record the successful login
        'attempt_count': 0, // Reset the failed attempt count
        'is_locked': false, // Unlock the account
      }, SetOptions(merge: true)); // Use merge to retain existing fields

      return userCredential.user; // Successful login
    } catch (e) {
      await _handleFailedLogin(email, context); // Handle failed login attempts
      return null; // Return null on failure
    }
  }

  // Handle failed login attempts for email/password
  Future<void> _handleFailedLogin(String email, BuildContext context) async {
    final docRef = _loginAttemptsCollection.doc(email);
    final doc = await docRef.get();

    int attemptCount = 0;

    if (doc.exists) {
      attemptCount = doc['attempt_count'] ?? 0; // Get current attempt count
    }

    attemptCount += 1; // Increment attempt count
    bool isLocked = attemptCount >= 3; // Lockout after 3 failed attempts

    // Update lockout status and last failed login time
    await docRef.set({
      'last_failed_login': FieldValue.serverTimestamp(), // Record failed login
      'attempt_count': attemptCount,
      'is_locked': isLocked,
    }, SetOptions(merge: true)); // Use merge to retain existing fields

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed. Attempt count: $attemptCount")),
    );
  }

  // Google sign-in
  Future<User?> signInWithGoogle(BuildContext context) async {
    final googleSignIn = GoogleSignIn(); // Google Sign-In instance
    try {
      final googleUser = await googleSignIn.signIn(); // Attempt to sign in via Google
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      final googleAuth = await googleUser.authentication; // Get Google authentication details
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential); // Sign in with Google credentials
      return userCredential.user; // Successful Google sign-in
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during Google sign-in: $e")),
      );
      return null; // Return null on failure
    }
  }
}
