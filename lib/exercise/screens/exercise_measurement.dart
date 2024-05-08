import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/exercise_measurement_controller.dart';
import '../services/exercise_service.dart';
import '../services/exercise_log.dart';
import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';
import '../../videos/video_list.dart';
import '../../home/home.dart';
import '../../profile/profile.dart';
import '../../profile/userprovider.dart'; // To access the current user
import 'exercise_categories.dart';

class ExerciseMeasurementView extends StatefulWidget {
  final String exerciseName;
  final String category;

  const ExerciseMeasurementView({
    required this.exerciseName,
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  _ExerciseMeasurementViewState createState() =>
      _ExerciseMeasurementViewState();
}

class _ExerciseMeasurementViewState extends State<ExerciseMeasurementView> {
  late ExerciseMeasurementController controller;
  int _currentIndex = 1;
  late ExerciseLogService exerciseLogService; // Instance of the log service
  late UserProvider userProvider; // User provider to get current user info

  @override
  void initState() {
    super.initState();
    exerciseLogService = ExerciseLogService(); // Initialize the service
    userProvider = UserProvider(); // Initialize the user provider

    controller = ExerciseMeasurementController(
      exerciseName: widget.exerciseName,
      category: widget.category,
      exerciseLogService: exerciseLogService, // Pass the service to the controller
      userProvider: userProvider, // Pass the user provider to the controller
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = ExerciseService.getExerciseDetails(
        widget.category, widget.exerciseName);

    if (exercise == null) {
      return Scaffold(
        appBar: CustomGradientAppBar(),
        body: Center(
          child: Text("Details for the selected exercise could not be found."),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
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
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideosPage(),
                  ),
                );
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

    return Scaffold(
        appBar: CustomGradientAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(exercise.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Total Sets: ${controller.totalSets}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: controller.totalSets,
                        itemBuilder: (context, index) {
                          return Card(
                            color: controller.selectedSets.contains(index)
                                ? Colors.orange.shade200
                                : Colors.white,
                            child: ListTile(
                              leading: Checkbox(
                                value: controller.selectedSets.contains(index),
                                onChanged: (bool? checked) { // Corrected callback
                                  setState(() {
                                    if (checked == true) {
                                      controller.addSelectedSet(index);
                                    } else {
                                      controller.removeSelectedSet(index);
                                    }
                                  });
                                },
                              ),
                              title: Text(
                                "Set ${index + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle:
                              Text("Reps: ${controller.setReps[index]}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    controller.removeSelectedSet(index); // Removes the set
                                  });
                                },
                              ),
                              onTap: () {
                                if (!controller.setCompleted[index]) {
                                  controller.setCurrentSet(index); // Set current set
                                  setState(() {});
                                }
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: (!controller.isLoggingSet &&
                            controller.restTimer == 0)
                            ? () async {
                          await controller.logSet(context); // Log the sets
                          setState(() {}); // Refresh UI after logging
                        }
                            : null, // Disable if logging in progress
                        child: controller.isLoggingSet
                            ? SpinKitRing(
                          color: Colors.white,
                          size: 24,
                        )
                            : Text(
                          "Log Set",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isLoggingSet
                              ? Colors.grey.shade700
                              : Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
    onPressed: () {
    controller.addSetWithReps(10); // Add a new set with 10 reps
    setState(() {}); // Refresh UI after adding a new set
    },
    ),
    bottomNavigationBar: CustomBottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: (index) {
    setState(() {
    _currentIndex = index; // Update the current index
    });
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
    case 2:
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => VideosPage(),
    ),
    );
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
    )
    );
  }
}
