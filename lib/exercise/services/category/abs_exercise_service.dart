import '../exercise.dart'; // Import the Exercise class

class AbsExerciseService {
  static final List<Exercise> absExercises = [
    Exercise(
      name: 'Plank',
      level: 'Beginner',
      description:
          'A core-strengthening exercise that involves holding a static position.',
      steps: [
        'Start in a push-up position with your forearms on the ground.',
        'Keep your body in a straight line from head to heels.',
        'Hold the position as long as possible.',
      ],
      imagePath: 'assets/images/plank.jpg',
    ),
  ];

  static List<Exercise> getAbsExercises() {
    return absExercises;
  }
}
