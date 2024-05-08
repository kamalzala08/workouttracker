import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/exercise_measurement_controller.dart'; // Controller import
import '../services/exercise_service.dart'; // Service for exercise data
import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';
import '../../videos/video_list.dart';
import '../../home/home.dart';
import '../../profile/profile.dart';
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

  @override
  void initState() {
    super.initState();
    controller = ExerciseMeasurementController(
      exerciseName: widget.exerciseName,
      category: widget.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = ExerciseService.getExerciseDetails(
        widget.category, widget.exerciseName);

    if (exercise == null) {
      return Scaffold(
        appBar: CustomGradientAppBar(),

        // appBar: AppBar(
        //   leading: BackButton(
        //     color: Colors.white,
        //   ),
        //   title: Text("Exercise Not Found"),
        //   backgroundColor: Colors.orange.shade700,
        //   centerTitle: true,
        // ),
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          exercise.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Total Sets: ${controller.totalSets}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.totalSets,
                        itemBuilder: (context, index) {
                          return Card(
                            color: index == controller.currentSet
                                ? Colors.orange.shade200
                                : Colors.white,
                            child: ListTile(
                              leading: Icon(
                                controller.setCompleted[index]
                                    ? FontAwesomeIcons.checkCircle
                                    : FontAwesomeIcons.circle,
                                color: controller.setCompleted[index]
                                    ? Colors.green.shade700
                                    : Colors.grey,
                              ),
                              title: Text("Set ${index + 1}"),
                              subtitle:
                                  Text("Reps: ${controller.setReps[index]}"),
                              trailing: IconButton(
                                icon: Icon(Icons.edit,
                                    color: Colors.orange.shade700),
                                onPressed: controller.setCompleted[index]
                                    ? null
                                    : () => controller.editReps(context,
                                        index), // Corrected method call
                              ),
                              onTap: () {
                                if (!controller.setCompleted[index]) {
                                  controller.setCurrentSet(index);
                                  setState(() {}); // Ensure UI updates
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed:
                      (!controller.isLoggingSet && controller.restTimer == 0)
                          ? () => controller.logSet(context)
                          : null,
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
          if (controller.restTimer > 0)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: CircularPercentIndicator(
                  radius: 100,
                  percent: controller.restTimer / 60,
                  lineWidth: 12,
                  progressColor: Colors.orange.shade700,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.clock,
                        color: Colors.white,
                        size: 36,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Break Time",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "${controller.restTimer}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
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
}
