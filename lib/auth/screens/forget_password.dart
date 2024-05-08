import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For icons
import '../services/forget_password_service.dart'; // ForgetPasswordService

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final ForgetPasswordService _forgetPasswordService = ForgetPasswordService(); // ForgetPasswordService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.orange.shade700, // Consistent color theme
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24), // Consistent padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Corrected spelling
              children: [
                // Instruction text
                Text(
                  'Enter your email to receive a password reset link.',
                  style: TextStyle(fontSize: 18, color: Colors.black), // Consistent text style
                  textAlign: TextAlign.center, // Centered text alignment
                ),
                SizedBox(height: 24), // Adequate spacing

                // Email input field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.orange.shade700), // Matching icon
                    filled: true,
                    fillColor: Colors.white, // White background for readability
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black), // Black text for contrast
                ),
                SizedBox(height: 24), // Spacing before the button

                // Reset Password Button with consistent styling
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text(
                    'Send Reset Link',
                    style: TextStyle(
                      color: Colors.white, // Consistent button text color
                      fontWeight: FontWeight.bold, // Bold text for emphasis
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700, // Matching color
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 125), // Adequate padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  // Reset password logic with proper error handling
  void _resetPassword() async {
    final email = _emailController.text.trim(); // Ensure clean email input

    try {
      await _forgetPasswordService.sendPasswordResetEmail(email);

      // Success message when the reset link is sent
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent to $email.')),
      );
    } catch (e) {
      // Error handling for failure to send reset link
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send reset link: $e")),
      );
    }
  }
}
