import '../exercise.dart'; // Import the Exercise class

class TricepsExerciseService {
  static final List<Exercise> tricepsExercises = [
    Exercise(
      exerciseId: '016',
      name: 'Tricep Dips',
      level: 'Intermediate',
      description:
          'A classic triceps exercise that uses body weight to build strength.',
      steps: [
        'Sit on a bench with your hands behind you, gripping the edge.',
        'Extend your legs and lower your body by bending your elbows.',
        'Push back up to the starting position.',
      ],
      imagePath: 'assets/images/tricep_dips.jpg',
    ),
  ];

  static List<Exercise> getTricepsExercises() {
    return tricepsExercises;
  }
}
