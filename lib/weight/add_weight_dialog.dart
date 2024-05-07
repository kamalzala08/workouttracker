import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddWeightDialog extends StatefulWidget {
  final Function(double, DateTime) onAdd; // Callback for adding weight

  AddWeightDialog({required this.onAdd}); // Pass in the callback

  @override
  _AddWeightDialogState createState() => _AddWeightDialogState();
}

class _AddWeightDialogState extends State<AddWeightDialog> {
  final TextEditingController _weightController = TextEditingController();
  final DateTime _today = DateTime.now(); // Today's date

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      backgroundColor: Colors.orange.shade50, // Soft background color
      title: Text(
        'Add Today\'s Weight',
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
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Weight (kg)', // Label for weight entry
              prefixIcon: Icon(Icons.fitness_center),
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
          onPressed: _addWeight, // Add the new weight entry
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

  void _addWeight() {
    final weightText = _weightController.text;
    if (weightText.isNotEmpty) {
      final weight = double.parse(weightText); // Convert text to double
      widget.onAdd(weight, _today); // Call the callback to add weight
      Navigator.of(context).pop(); // Close the dialog after adding
    }
  }
}
