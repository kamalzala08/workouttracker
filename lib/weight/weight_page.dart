import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'add_weight_dialog.dart'; // Import the dialog class

class WeightPage extends StatefulWidget {
  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  List<WeightData> allWeightData =
      _generateDummyData(); // 50 days of dummy data
  List<WeightData> displayedData = [];
  String _selectedFilter = '7 days'; // Default filter

  @override
  void initState() {
    super.initState();
    _applyFilter(_selectedFilter); // Apply initial filter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Tracker'),
        backgroundColor: Colors.orange,
        actions: [
          PopupMenuButton<String>(
            onSelected: _applyFilter,
            itemBuilder: (context) => [
              PopupMenuItem(value: '7 days', child: Text('Last 7 Days')),
              PopupMenuItem(value: '30 days', child: Text('Last 30 Days')),
              PopupMenuItem(value: '3 months', child: Text('Last 3 Months')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedFilter,
              dropdownColor: Colors.orange.shade100,
              underline: Container(
                height: 2,
                color: Colors.orange,
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                  _applyFilter(_selectedFilter); // Apply the selected filter
                });
              },
              items: [
                DropdownMenuItem(value: '7 days', child: Text('Last 7 Days')),
                DropdownMenuItem(value: '30 days', child: Text('Last 30 Days')),
                DropdownMenuItem(
                    value: '3 months', child: Text('Last 3 Months')),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: charts.TimeSeriesChart(
                _getChartData(displayedData),
                animate: true,
                defaultRenderer: charts.LineRendererConfig(
                  includeArea: true,
                  includePoints: true,
                ),
                behaviors: [
                  charts.SelectNearest(), // Enable hover interaction
                  charts.LinePointHighlighter(), // Highlight points on hover
                ],
                domainAxis: charts.EndPointsTimeAxisSpec(
                  tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                    day: charts.TimeFormatterSpec(
                      format: 'MM/dd',
                      transitionFormat: 'MM/dd',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showAddWeightDialog(context); // Show the modal dialog
                },
                child: Text("Add Today's Weight"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32), // Padding for better visibility
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildWeightInfo(
                "Average Weight", _calculateAverageWeight(displayedData)),
            SizedBox(height: 16),
            _buildWeightInfo(
                "Minimum Weight", _calculateMinWeight(displayedData)),
            SizedBox(height: 16),
            _buildWeightInfo(
                "Maximum Weight", _calculateMaxWeight(displayedData)),
            SizedBox(height: 16),
            _getWeightChangeMessage(), // Display weight change message
          ],
        ),
      ),
    );
  }

  static List<WeightData> _generateDummyData() {
    final List<WeightData> data = [];
    final DateTime today = DateTime.now();

    for (int i = 0; i < 50; i++) {
      data.add(
        WeightData(
          today.subtract(Duration(days: i)), // 50 days of weight data
          70 + (i % 5), // Varying weight values
        ),
      );
    }

    return data.reversed.toList(); // Reverse for correct order
  }

  List<charts.Series<WeightData, DateTime>> _getChartData(
      List<WeightData> data) {
    return [
      charts.Series<WeightData, DateTime>(
        id: 'Weight',
        data: data,
        domainFn: (WeightData wd, _) => wd.date,
        measureFn: (WeightData wd, _) => wd.weight,
        colorFn: (_, __) =>
            charts.MaterialPalette.deepOrange.shadeDefault, // Line color
      ),
    ];
  }

  void _applyFilter(String filter) {
    final now = DateTime.now();
    DateTime startDate;

    switch (filter) {
      case '7 days':
        startDate = now.subtract(Duration(days: 7)); // Last 7 days
        break;
      case '30 days':
        startDate = now.subtract(Duration(days: 30)); // Last 30 days
        break;
      case '3 months':
        startDate = now.subtract(Duration(days: 90)); // Last 3 months
        break;
      default:
        startDate = now.subtract(Duration(days: 7)); // Default to 7 days
        break;
    }

    final filteredData =
        allWeightData.where((data) => data.date.isAfter(startDate)).toList();

    setState(() {
      displayedData = filteredData; // Update displayed data with the filter
    });
  }

  void _showAddWeightDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddWeightDialog(
          onAdd: (double weight, DateTime date) {
            allWeightData.add(WeightData(date, weight)); // Add new data
            _applyFilter(
                _selectedFilter); // Reapply the filter to update the display
          },
        );
      },
    );
  }

  Widget _buildWeightInfo(String label, String value) {
    return Container(
      padding: EdgeInsets.all(12), // Spacing within the container
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // Light shadow for depth
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            '$label:', // Display the label
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8), // Space between label and value
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade200, // Light orange for background
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: Text(
              value, // Display the value
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateAverageWeight(List<WeightData> data) {
    final totalWeight = data.fold(
        0.0, (sum, item) => sum + item.weight); // Calculate total weight
    return (totalWeight / data.length).toStringAsFixed(1); // Format average
  }

  String _calculateMinWeight(List<WeightData> data) {
    final minWeight = data.fold(
        double.infinity, (min, item) => item.weight < min ? item.weight : min);
    return minWeight.toStringAsFixed(1); // Format minimum
  }

  String _calculateMaxWeight(List<WeightData> data) {
    final maxWeight = data.fold(double.negativeInfinity,
        (max, item) => item.weight > max ? item.weight : max); // Find maximum
    return maxWeight.toStringAsFixed(1); // Format maximum
  }

  Widget _getWeightChangeMessage() {
    final firstWeight = displayedData.first.weight; // Initial weight
    final lastWeight = displayedData.last.weight; // Final weight

    final weightChange = lastWeight - firstWeight; // Calculate the change
    final weightChangeText = weightChange >= 0
        ? 'Gained ${weightChange.toStringAsFixed(1)} kg' // Gain
        : 'Lost ${(-weightChange).toStringAsFixed(1)} kg'; // Loss

    return Text(
      'You have $weightChangeText over the last $_selectedFilter', // Display message
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Bold text
    );
  }
}

class WeightData {
  final DateTime date; // Date of measurement
  final double weight; // Weight value

  WeightData(this.date, this.weight); // Constructor for weight data
}
