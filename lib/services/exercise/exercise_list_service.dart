import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Service to manage exercise data
class ExerciseService {
  // Exercise categories with icons
  static final List<Map<String, dynamic>> allCategories = [
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

  // Exercise list for each category with difficulty levels
  static final Map<String, List<Map<String, String>>> exerciseMap = {
    'Chest': [
      {'name': 'Bench Press', 'level': 'Intermediate'},
      {'name': 'Push-ups', 'level': 'Beginner'},
      {'name': 'Chest Fly', 'level': 'Intermediate'},
      {'name': 'Incline Bench Press', 'level': 'Intermediate'},
      {'name': 'Decline Bench Press', 'level': 'Expert'},
      {'name': 'Cable Crossover', 'level': 'Expert'},
    ],
    'Triceps': [
      {'name': 'Tricep Dips', 'level': 'Intermediate'},
      {'name': 'Tricep Extension', 'level': 'Beginner'},
      {'name': 'Skull Crushers', 'level': 'Expert'},
      {'name': 'Overhead Tricep Extension', 'level': 'Intermediate'},
      {'name': 'Close-Grip Bench Press', 'level': 'Intermediate'},
      {'name': 'Tricep Pushdown', 'level': 'Beginner'},
    ],
    'Lats': [
      {'name': 'Lat Pulldown', 'level': 'Intermediate'},
      {'name': 'Pull-Ups', 'level': 'Expert'},
      {'name': 'Bent Over Rows', 'level': 'Intermediate'},
      {'name': 'T-Bar Rows', 'level': 'Intermediate'},
      {'name': 'Seated Rows', 'level': 'Intermediate'},
      {'name': 'Wide-Grip Pull-Ups', 'level': 'Expert'},
    ],
    'Biceps': [
      {'name': 'Bicep Curl', 'level': 'Beginner'},
      {'name': 'Hammer Curl', 'level': 'Intermediate'},
      {'name': 'Concentration Curl', 'level': 'Intermediate'},
      {'name': 'Preacher Curl', 'level': 'Intermediate'},
      {'name': 'Barbell Curl', 'level': 'Intermediate'},
      {'name': 'Incline Curl', 'level': 'Intermediate'},
    ],
    'Shoulders': [
      {'name': 'Shoulder Press', 'level': 'Intermediate'},
      {'name': 'Lateral Raises', 'level': 'Intermediate'},
      {'name': 'Front Raises', 'level': 'Intermediate'},
      {'name': 'Rear Delt Fly', 'level': 'Intermediate'},
      {'name': 'Arnold Press', 'level': 'Intermediate'},
      {'name': 'Upright Rows', 'level': 'Intermediate'},
    ],
    'Abs': [
      {'name': 'Plank', 'level': 'Beginner'},
      {'name': 'Crunches', 'level': 'Beginner'},
      {'name': 'Leg Raises', 'level': 'Intermediate'},
      {'name': 'Russian Twists', 'level': 'Intermediate'},
      {'name': 'Bicycle Crunches', 'level': 'Intermediate'},
      {'name': 'Mountain Climbers', 'level': 'Intermediate'},
    ],
    'Forearms': [
      {'name': 'Wrist Curls', 'level': 'Beginner'},
      {'name': 'Reverse Curls', 'level': 'Intermediate'},
      {'name': 'Farmer\'s Walk', 'level': 'Beginner'},
      {'name': 'Wrist Rollers', 'level': 'Intermediate'},
      {'name': 'Plate Pinches', 'level': 'Intermediate'},
      {'name': 'Finger Curls', 'level': 'Beginner'},
    ],
    'Traps': [
      {'name': 'Shrugs', 'level': 'Beginner'},
      {'name': 'Face Pulls', 'level': 'Intermediate'},
      {'name': 'Upright Rows', 'level': 'Intermediate'},
      {'name': 'Trap Bar Deadlifts', 'level': 'Intermediate'},
      {'name': 'Farmers Walk', 'level': 'Beginner'},
      {'name': 'Face Pulls', 'level': 'Intermediate'},
    ],
    'Glutes': [
      {'name': 'Hip Thrusts', 'level': 'Intermediate'},
      {'name': 'Glute Bridges', 'level': 'Beginner'},
      {'name': 'Donkey Kicks', 'level': 'Beginner'},
      {'name': 'Single-Leg Glute Bridge', 'level': 'Intermediate'},
      {'name': 'Lunges', 'level': 'Beginner'},
      {'name': 'Cable Pull Through', 'level': 'Intermediate'},
    ],
    'Quads': [
      {'name': 'Squats', 'level': 'Beginner'},
      {'name': 'Lunges', 'level': 'Intermediate'},
      {'name': 'Leg Extensions', 'level': 'Beginner'},
      {'name': 'Leg Press', 'level': 'Intermediate'},
      {'name': 'Hack Squat', 'level': 'Intermediate'},
      {'name': 'Step-Ups', 'level': 'Intermediate'},
    ],
    'Hamstrings': [
      {'name': 'Leg Curl', 'level': 'Beginner'},
      {'name': 'Deadlifts', 'level': 'Intermediate'},
      {'name': 'Good Mornings', 'level': 'Intermediate'},
      {'name': 'Romanian Deadlifts', 'level': 'Intermediate'},
      {'name': 'Glute-Ham Raise', 'level': 'Expert'},
      {'name': 'Single-Leg Deadlifts', 'level': 'Intermediate'},
    ],
    'Calves': [
      {'name': 'Calf Raises', 'level': 'Beginner'},
      {'name': 'Seated Calf Raises', 'level': 'Beginner'},
      {'name': 'Donkey Calf Raises', 'level': 'Beginner'},
      {'name': 'Standing Calf Raises', 'level': 'Beginner'},
      {'name': 'Leg Press Calf Raises', 'level': 'Beginner'},
      {'name': 'Single-Leg Calf Raises', 'level': 'Intermediate'},
    ],
  };

  // Get the list of exercises for a specific category
  static List<Map<String, String>> getExercisesForCategory(String category) {
    return exerciseMap[category] ?? [];
  }

  // Get the icon for a specific category
  static dynamic getCategoryIcon(String category) {
    return allCategories
        .firstWhere((element) => element['name'] == category)['icon'];
  }
}
