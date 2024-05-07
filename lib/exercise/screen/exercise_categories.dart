import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'exercise_list.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExerciseCategories extends StatefulWidget {
  @override
  _ExerciseCategoriesState createState() => _ExerciseCategoriesState();
}

class _ExerciseCategoriesState extends State<ExerciseCategories> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> allCategories = [
    {'name': 'Chest', 'icon': FontAwesomeIcons.handHoldingHeart},
    {'name': 'Triceps', 'icon': FontAwesomeIcons.handPointUp},
    {'name': 'Lats', 'icon': FontAwesomeIcons.leaf},
    {'name': 'Biceps', 'icon': FontAwesomeIcons.handFist},
    {'name': 'Shoulders', 'icon': FontAwesomeIcons.user},
    {'name': 'Abs', 'icon': FontAwesomeIcons.crosshairs},
    {'name': 'Forearms', 'icon': FontAwesomeIcons.handshake},
    {'name': 'Traps', 'icon': FontAwesomeIcons.personBooth},
    {'name': 'Glutes', 'icon': FontAwesomeIcons.hippo},
    {'name': 'Quads', 'icon': FontAwesomeIcons.running},
    {'name': 'Hamstrings', 'icon': FontAwesomeIcons.road},
    {'name': 'Calves', 'icon': FontAwesomeIcons.chevronDown},
  ];

  List<Map<String, dynamic>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(allCategories);
  }

  void _filterCategories(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        filteredCategories = List.from(allCategories);
      } else {
        filteredCategories = allCategories
            .where((category) => category['name']
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade700, Colors.orange.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Icon(
          FontAwesomeIcons.dumbbell,
          color: Colors.white,
        ),
        title: Text(
          "Select Exercise Category",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search category...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterCategories,
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseList(
                              category: category['name'],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            category['icon'],
                            size: 50,
                            color: Colors.orange.shade700,
                          ),
                          SizedBox(height: 8),
                          Text(
                            category['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
