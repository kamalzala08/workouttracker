import '../exercise.dart'; // Import the Exercise class

class ShouldersExerciseService {
  static final List<Exercise> shouldersExercises = [
    Exercise(
      name: 'Shoulder Press',
      level: 'Intermediate',
      description:
          'A key exercise for building shoulder strength, primarily targeting the deltoids.',
      steps: [
        'Sit on a bench with a backrest, holding dumbbells at shoulder level.',
        'Press the dumbbells upward, extending your arms overhead.',
        'Lower the dumbbells back to shoulder level to complete the repetition.',
      ],
      imagePath: 'assets/images/shoulder_press.jpg',
    ),
  ];

  static List<Exercise> getShouldersExercises() {
    return shouldersExercises;
  }
}
