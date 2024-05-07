import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'category/triceps_exercise_service.dart';
import 'category/chest_exercise_service.dart';
import 'category/lats_exercise_service.dart';
import 'category/biceps_exercise_service.dart';
import 'category/shoulders_exercise_service.dart';
import 'category/abs_exercise_service.dart';
import 'category/forearms_exercise_service.dart';
import 'category/traps_exercise_service.dart';
import 'category/glutes_exercise_service.dart';
import 'category/quads_exercise_service.dart';
import 'category/hamstrings_exercise_service.dart';
import 'category/calves_exercise_service.dart';
import 'exercise.dart';

class ExerciseService {
  // Central list of exercise categories with icons
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

  // Fetch exercises for a given category
  static List<Exercise> getExercisesForCategory(String category) {
    switch (category) {
      case 'Chest':
        return ChestExerciseService.getChestExercises();
      case 'Triceps':
        return TricepsExerciseService.getTricepsExercises();
      case 'Lats':
        return LatsExerciseService.getLatsExercises();
      case 'Biceps':
        return BicepsExerciseService.getBicepsExercises();
      case 'Shoulders':
        return ShouldersExerciseService.getShouldersExercises();
      case 'Abs':
        return AbsExerciseService.getAbsExercises();
      case 'Forearms':
        return ForearmsExerciseService.getForearmsExercises();
      case 'Traps':
        return TrapsExerciseService.getTrapsExercises();
      case 'Glutes':
        return GlutesExerciseService.getGlutesExercises();
      case 'Quads':
        return QuadsExerciseService.getQuadsExercises();
      case 'Hamstrings':
        return HamstringsExerciseService.getHamstringsExercises();
      case 'Calves':
        return CalvesExerciseService.getCalvesExercises();
      default:
        return [];
    }
  }

  // Fetch the icon for a specific category
  // Get the icon for a specific category
  static dynamic getCategoryIcon(String category) {
    return allCategories
        .firstWhere((element) => element['name'] == category)['icon'];
  }

  // Fetch specific exercise based on name and category
  static Exercise? getExerciseDetails(String category, String exerciseName) {
    final exercises = getExercisesForCategory(category);

    return exercises.firstWhere(
      (exercise) => exercise.name == exerciseName,
    );
  }
}
