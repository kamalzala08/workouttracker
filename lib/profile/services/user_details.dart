import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  static Future<String?> getEmail(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot['email'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching email: $e');
      return null;
    }
  }

  static Future<void> setEmail(String uid, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'email': email,
      });
    } catch (e) {
      print('Error setting email: $e');
    }
  }

  static Future<String?> getGender(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot['gender'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching gender: $e');
      return null;
    }
  }

  static Future<void> setGender(String uid, String gender) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'gender': gender,
      });
    } catch (e) {
      print('Error setting gender: $e');
    }
  }
}
