import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'exercise_details.dart';
import '../services/exercise_service.dart'; // Central service for fetching category data
import '../services/exercise.dart'; // Exercise class
import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';
import '../../videos/video_list.dart';
import '../../home/home.dart';
import '../../profile/profile.dart';
import 'exercise_categories.dart';

class ExerciseList extends StatefulWidget {
  final String category;

  ExerciseList({required this.category});

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  int _currentIndex = 1;
  late List<Exercise> exercises;
  late IconData categoryIcon;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    exercises = ExerciseService.getExercisesForCategory(widget.category);
    categoryIcon = ExerciseService.getCategoryIcon(widget.category);
  }

  void _sortExercisesByName() {
    setState(() {
      exercises.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void _sortExercisesByLevel() {
    const levelOrder = ['Beginner', 'Intermediate', 'Expert'];

    setState(() {
      exercises.sort((a, b) =>
          levelOrder.indexOf(a.level).compareTo(levelOrder.indexOf(b.level)));
    });
  }

  List<Exercise> _filterExercises(String searchTerm) {
    if (searchTerm.isEmpty) {
      return exercises;
    } else {
      return exercises
          .where((exercise) =>
              exercise.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredExercises = _filterExercises(_searchController.text);

    return Scaffold(
      appBar: CustomGradientAppBar(),

      // appBar: AppBar(
      //   leading: Row(
      //     children: [
      //       IconButton(
      //         icon: Icon(
      //           Icons.arrow_back,
      //           color: Colors.white,
      //         ),
      //         onPressed: () => Navigator.pop(context),
      //       ),
      //       Icon(
      //         categoryIcon,
      //         color: Colors.white,
      //         size: 16,
      //       ),
      //     ],
      //   ),
      //   title: Text(
      //     "${widget.category} Exercises",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.orange.shade700, Colors.orange.shade400],
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (_) => setState(() {}), // Trigger refresh
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_alt),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.sort_by_alpha),
                              title: Text("Sort by Name"),
                              onTap: () {
                                _sortExercisesByName();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.sort),
                              title: Text("Sort by Level"),
                              onTap: () {
                                _sortExercisesByLevel();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = filteredExercises[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.dumbbell,
                        color: Colors.orange.shade700,
                      ),
                      title: Text(
                        exercise.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                      subtitle: Text(
                        'Level: ${exercise.level}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetails(
                                exerciseName: exercise.name,
                                category: widget.category),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
//kmal
