import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For loading spinner
import '../services/login_service.dart';
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
  final LoginService _loginService = LoginService();
  bool _isPasswordVisible = false; // To control password visibility
  bool _isLoading = false; // For loading indication

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Brand icon with title
                Icon(
                  FontAwesomeIcons.dumbbell,
                  color: Colors.orange.shade700,
                  size: 80,
                ),
                SizedBox(height: 24),
                Text(
                  'Welcome to WorkOutTracker',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
                SizedBox(height: 32),

                // Email Text Field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.orange.shade700),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 16),

                // Password Text Field with Show/Hide Toggle
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.orange.shade700),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.orange.shade700,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  obscureText: !_isPasswordVisible, // Hide text by default
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 8),

                // "Forgot Password?" positioned below the password field
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _forgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),

                // Login Button matching text field width
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? SpinKitCircle(color: Colors.white, size: 24)
                        : Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Google Sign-In Button matching text field width
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _loginWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white),
                        SizedBox(width: 8),
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
                      backgroundColor: Colors.red.shade600,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),

                // "Don't have an account?" with clickable "Register now"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: _createAccount,
                      child: Text(
                        'Register now!',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    _loginService.signInWithEmailAndPassword(email, password, context).then((user) {
      setState(() {
        _isLoading = false;
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
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during login: $e")),
      );
    });
  }

  void _loginWithGoogle() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    _loginService.signInWithGoogle(context).then((user) {
      setState(() {
        _isLoading = false;
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
        _isLoading = false;
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
