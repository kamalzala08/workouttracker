import 'package:flutter/material.dart';
import 'user.dart';

class UserProvider extends ChangeNotifier {
  late User _currentUser;

  User get currentUser => _currentUser;

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

// Add other methods to update user data as needed
}
