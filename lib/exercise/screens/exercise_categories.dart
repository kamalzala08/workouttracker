import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'exercise_list.dart';
import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';
import '../../videos/video_list.dart';
import '../../home/home.dart';
import '../../profile/profile.dart';

class ExerciseCategories extends StatefulWidget {
  @override
  _ExerciseCategoriesState createState() => _ExerciseCategoriesState();
}

class _ExerciseCategoriesState extends State<ExerciseCategories> {
  int _currentIndex = 1;
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
      appBar: CustomGradientAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8), // Reduced padding here
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
            SizedBox(height: 8), // Reduced SizedBox height here
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8, // Reduced spacing here
                  mainAxisSpacing: 8, // Reduced spacing here
                  childAspectRatio: 1, // Adjusted aspect ratio
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Reduced border radius here
                    ),
                    elevation: 2, // Reduced elevation here
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
                      child: Padding(
                        padding:
                            const EdgeInsets.all(8), // Reduced padding here
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              category['icon'],
                              size: 40,
                              color: Colors.orange.shade700,
                            ),
                            SizedBox(height: 4), // Reduced SizedBox height here
                            Text(
                              category['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
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
