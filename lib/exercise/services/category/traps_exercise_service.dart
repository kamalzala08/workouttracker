import '../exercise.dart'; // Import the Exercise class

class TrapsExerciseService {
  static final List<Exercise> trapsExercises = [
    Exercise(
      exerciseId: '015',
      name: 'Shrugs',
      level: 'Beginner',
      description: 'An exercise to strengthen the trapezius muscles.',
      steps: [
        'Stand with a dumbbell in each hand, arms at your sides.',
        'Lift your shoulders toward your ears in a shrugging motion.',
        'Lower your shoulders back to the starting position.',
      ],
      imagePath: 'assets/images/shrugs.jpg',
    ),
  ];

  static List<Exercise> getTrapsExercises() {
    return trapsExercises;
  }
}
