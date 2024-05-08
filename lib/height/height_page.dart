import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'add_height_dialog.dart'; // Import the dialog class
import '../components/appbar.dart';
import '../components/bottom_navigation.dart';
import '../exercise/screens/exercise_categories.dart';
import '../home/home.dart';
import '../profile/profile.dart';

class HeightPage extends StatefulWidget {
  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage>
    with SingleTickerProviderStateMixin {
  List<HeightData> allHeightData =
      _generateDummyData(); // 50 days of dummy data
  List<HeightData> displayedData = [];
  String _selectedFilter = '7 days'; // Default filter
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _applyFilter(_selectedFilter); // Apply initial filter

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Animation duration
    );

    // Curve for smooth animation
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Tween for animating the line from 0.0 to 1.0
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomGradientAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                  DropdownMenuItem(
                      value: '30 days', child: Text('Last 30 Days')),
                  DropdownMenuItem(
                      value: '3 months', child: Text('Last 3 Months')),
                ],
              ),
              SizedBox(height: 16),
              FadeTransition(
                opacity: _animation, // Apply animation to the chart
                child: SizedBox(
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
                      charts
                          .LinePointHighlighter(), // Highlight points on hover
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
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showAddHeightDialog(context); // Show the modal dialog
                  },
                  child: Text("Add Today's Height"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 32), // Padding for better visibility
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildHeightInfo(
                  "Average Height", _calculateAverageHeight(displayedData)),
              SizedBox(height: 16),
              _buildHeightInfo(
                  "Minimum Height", _calculateMinHeight(displayedData)),
              SizedBox(height: 16),
              _buildHeightInfo(
                  "Maximum Height", _calculateMaxHeight(displayedData)),
              SizedBox(height: 16),
              _getHeightChangeMessage(), // Display height change message
              SizedBox(height: 100), // Add some extra space at the bottom
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle navigation based on index
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseCategories(),
                ),
              );
              break;
            case 2: // No need to navigate if already on VideosPage
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  static List<HeightData> _generateDummyData() {
    final List<HeightData> data = [];
    final DateTime today = DateTime.now();

    for (int i = 0; i < 50; i++) {
      data.add(
        HeightData(
          today.subtract(Duration(days: i)), // 50 days of height data
          160 + (i % 3), // Varying height values
        ),
      );
    }

    return data.reversed.toList(); // Reverse for correct order
  }

  List<charts.Series<HeightData, DateTime>> _getChartData(
      List<HeightData> data) {
    return [
      charts.Series<HeightData, DateTime>(
        id: 'Height',
        data: data,
        domainFn: (HeightData hd, _) => hd.date,
        measureFn: (HeightData hd, _) => hd.height,
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
        allHeightData.where((data) => data.date.isAfter(startDate)).toList();

    setState(() {
      displayedData = filteredData; // Update displayed data with the filter
    });
  }

  void _showAddHeightDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddHeightDialog(
          onAdd: (double height, DateTime date) {
            allHeightData.add(HeightData(date, height)); // Add new data
            _applyFilter(
                _selectedFilter); // Reapply the filter to update the display
          },
        );
      },
    );
  }

  Widget _buildHeightInfo(String label, String value) {
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

  String _calculateAverageHeight(List<HeightData> data) {
    final totalHeight = data.fold(
        0.0, (sum, item) => sum + item.height); // Calculate total height
    return (totalHeight / data.length).toStringAsFixed(1); // Format average
  }

  String _calculateMinHeight(List<HeightData> data) {
    final minHeight = data.fold(
        double.infinity, (min, item) => item.height < min ? item.height : min);
    return minHeight.toStringAsFixed(1); // Format minimum
  }

  String _calculateMaxHeight(List<HeightData> data) {
    final maxHeight = data.fold(double.negativeInfinity,
        (max, item) => item.height > max ? item.height : max); // Find maximum
    return maxHeight.toStringAsFixed(1); // Format maximum
  }

  Widget _getHeightChangeMessage() {
    final firstHeight = displayedData.first.height; // Initial height
    final lastHeight = displayedData.last.height; // Final height

    final heightChange = lastHeight - firstHeight; // Calculate the change
    final heightChangeText = heightChange >= 0
        ? 'Gained ${heightChange.toStringAsFixed(1)} cm' // Gain
        : 'Lost ${(-heightChange).toStringAsFixed(1)} cm'; // Loss

    return Text(
      'You have $heightChangeText over the last $_selectedFilter', // Display message
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Bold text
    );
  }
}

class HeightData {
  final DateTime date; // Date of measurement
  final double height; // Height value

  HeightData(this.date, this.height); // Constructor for height data
}
