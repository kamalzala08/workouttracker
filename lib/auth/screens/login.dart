import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Loading spinner
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For Google icon
import '../services/login_service.dart'; // Importing the LoginService
import 'forget_password.dart'; // Forgot password screen
import 'registration.dart'; // Registration screen
import '../../welcome_screen.dart'; // Welcome screen

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService(); // Instance of LoginService
  bool _isLoading = false; // Loading indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24), // Increased padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Corrected alignment
              children: [
                // App logo or brand element
                Icon(
                  FontAwesomeIcons.dumbbell, // Example workout-themed icon
                  color: Colors.orange.shade700,
                  size: 64,
                ),
                SizedBox(height: 24), // Proper spacing

                // App title or welcome message
                Text(
                  'Welcome to WorkOutTracker',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
                SizedBox(height: 24), // Consistent spacing

                // Email Text Field with consistent design
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.orange.shade700),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black), // Use black for text
                ),
                SizedBox(height: 16), // Corrected spacing

                // Password Text Field with consistent design
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.orange.shade700),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true, // Hide password text
                  style: TextStyle(color: Colors.black), // Use black for text
                ),
                SizedBox(height: 24), // Corrected spacing

                // Login Button with Loading Indicator
                ElevatedButton(
                  onPressed: _isLoading ? null : _login, // Check loading state
                  child: _isLoading
                      ? SpinKitCircle(color: Colors.white, size: 24) // Loading spinner
                      : Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700, // Orange accent
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16), // Proper spacing

                // Google Login Button with consistent design
                ElevatedButton(
                  onPressed: _isLoading ? null : _loginWithGoogle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.white), // Google icon
                      SizedBox(width: 8), // Corrected spacing
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600, // Google brand color
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16), // Proper spacing

                // Forgot Password with Text Button
                TextButton(
                  onPressed: _forgotPassword,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16), // Consistent spacing

                // Create New Account with Text Button
                TextButton(
                  onPressed: _createAccount,
                  child: Text(
                    'Create New Account',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true; // Start the loading spinner
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    _loginService.signInWithEmailAndPassword(email, password, context).then((user) {
      setState(() {
        _isLoading = false; // Stop the loading spinner
      });

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen(userEmail: email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed. Please check your credentials and try again.")),
        );
      }
    }).catchError((e) {
      setState(() {
        _isLoading = false; // Stop the loading spinner
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during login: $e")),
      );
    });
  }

  void _loginWithGoogle() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true; // Start the loading spinner
    });

    _loginService.signInWithGoogle(context).then((user) {
      setState(() {
        _isLoading = false; // Stop the spinner after Google login attempt
      });

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen(userEmail: user.email ?? '')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google sign-in failed. Please try again.")),
        );
      }
    }).catchError((e) {
      setState(() {
        _isLoading = false; // Ensure spinner stops in case of error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during Google sign-in: $e")),
      );
    });
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgetPassword()),
    );
  }

  void _createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registration()),
    );
  }
}
