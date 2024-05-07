import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart'; // For TapGestureRecognizer
import '../services/registration_service.dart'; // Custom registration service
import '../../welcome_screen.dart'; // After registration
import 'login.dart'; // Redirect for existing users


class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final RegistrationService _registrationService = RegistrationService(); // Service for registration
  bool _isPasswordVisible = false; // Show or hide password text
  String _passwordHint = ''; // Hint for password strength
  Color _hintColor = Colors.orange.shade700; // Color for password hint
  String? _gender; // Store the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24), // Padding for spacing
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.dumbbell, // App icon
                color: Colors.orange.shade700,
                size: 64, // Icon size
              ),
              SizedBox(height: 24),
              Text(
                'Join WorkoutTracker', // Registration title
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name', // Label for name
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  prefixIcon: Icon(
                    FontAwesomeIcons.user, // Icon for name field
                    color: Colors.orange.shade700,
                  ),
                  filled: true,
                  fillColor: Colors.white, // White background
                ),
                style: TextStyle(color: Colors.black), // Text style
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email', // Email label
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.orange.shade700,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress, // Email keyboard type
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Hide/show password text
                decoration: InputDecoration(
                  labelText: 'Password', // Label for password
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.orange.shade700,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.orange.shade700,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  helperText: _passwordHint, // Display password hint
                  helperStyle: TextStyle(color: _hintColor), // Hint color
                ),
                style: TextStyle(color: Colors.black), // Text style
                onChanged: _updatePasswordHint, // Password hint logic
              ),
              SizedBox(height: 16),
              TextField(
                controller: _dobController,
                readOnly: true, // Make Date of Birth field read-only
                decoration: InputDecoration(
                  labelText: 'Date of Birth', // Label for Date of Birth
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.orange.shade700,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onTap: _pickDate, // Opens date picker
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender, // Current gender value
                decoration: InputDecoration(
                  labelText: 'Gender', // Label for gender
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(
                    Icons.wc,
                    color: Colors.orange.shade700,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _register, // Registration function
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Button shape
                  ),
                ),
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                  children: [
                    TextSpan(
                      text: 'Login here!',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _redirectToLogin, // Navigate to login
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text.trim();
    final dob = _dobController.text.trim();
    final gender = _gender;

    if (!_isPasswordStrong(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 12 characters long, with uppercase, lowercase, numbers, and special characters.")),
      );
      return;
    }

    try {
      _registrationService.registerWithEmailAndPassword(
        email,
        password,
        name,
        dob,
        gender,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration successful! Welcome, $name!")),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen(userEmail: email)), // Navigate to welcome screen
        );
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    }
  }

  bool _isPasswordStrong(String password) {
    return password.length >= 12 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void _updatePasswordHint(String input) {
    setState(() {
      if (input.length < 8) {
        _passwordHint = 'Password is too short';
        _hintColor = Colors.red; // Set hint color for weak password
      } else {
        _passwordHint = 'Password strength: Strong'; // Strong password
        _hintColor = Colors.green; // Hint color for strong password
      }
    });
  }

  void _pickDate() {
    final initialDate = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: initialDate,
    ).then((newDate) {
      if (newDate != null) {
        _dobController.text = DateFormat('yyyy-MM-dd').format(newDate); // Set DOB in field
      }
    });
  }

  void _redirectToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()), // Navigate to login
    );
  }
}
