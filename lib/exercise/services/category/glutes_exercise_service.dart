import '../exercise.dart'; // Import the Exercise class

class GlutesExerciseService {
  static final List<Exercise> glutesExercises = [
    Exercise(
      exerciseId: '010',
      name: 'Hip Thrusts',
      level: 'Intermediate',
      description:
          'An exercise that targets the glute muscles, helping build strength and size.',
      steps: [
        'Sit on the ground with your back against a bench, with a barbell over your hips.',
        'Drive through your heels to lift your hips until your body forms a straight line from shoulders to knees.',
        'Lower your hips back down to the starting position.',
      ],
      imagePath: 'assets/images/hip_thrusts.jpg',
    ),
  ];

  static List<Exercise> getGlutesExercises() {
    return glutesExercises;
  }
}
