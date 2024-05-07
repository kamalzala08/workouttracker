import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error sending password reset email: $e");
      throw e; // Rethrow the error to handle it in the UI
    }
  }
}
