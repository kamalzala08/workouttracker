import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHeightDialog extends StatefulWidget {
  final Function(double, DateTime) onAdd; // Callback for adding height

  AddHeightDialog({required this.onAdd}); // Pass in the callback

  @override
  _AddHeightDialogState createState() => _AddHeightDialogState();
}

class _AddHeightDialogState extends State<AddHeightDialog> {
  final TextEditingController _heightController = TextEditingController();
  final DateTime _today = DateTime.now(); // Today's date

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      backgroundColor: Colors.orange.shade50, // Soft background color
      title: Text(
        'Add Today\'s Height',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.orange, // Orange title text
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display today's date
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              DateFormat('EEEE, MMMM dd, yyyy')
                  .format(_today), // Formatted date
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800, // Bold orange color
              ),
            ),
          ),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Height (cm)', // Label for height entry
              prefixIcon: Icon(Icons.height),
              filled: true, // Filled background for text field
              fillColor: Colors.white70, // Light fill color
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without adding
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.orange.shade600, // Orange text
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _addHeight, // Add the new height entry
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.white, // White text for better visibility
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade800, // Orange background
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            animationDuration: Duration(milliseconds: 300), // Animation effect
          ),
        ),
      ],
    );
  }

  void _addHeight() {
    final heightText = _heightController.text.trim();
    if (heightText.isNotEmpty) {
      final height = double.tryParse(heightText);
      if (height != null && height > 0) {
        widget.onAdd(height, _today); // Call the callback to add height
        Navigator.of(context).pop(); // Close the dialog after adding
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid height.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your height.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
