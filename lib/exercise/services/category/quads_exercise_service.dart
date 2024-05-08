import '../exercise.dart'; // Import the Exercise class

class QuadsExerciseService {
  static final List<Exercise> quadsExercises = [
    Exercise(
      exerciseId: '013',
      name: 'Squats',
      level: 'Beginner',
      description:
          'A fundamental exercise for building quad strength and overall lower body conditioning.',
      steps: [
        'Stand with your feet shoulder-width apart, holding a barbell across your shoulders.',
        'Bend your knees to lower your body into a squat, keeping your back straight.',
        'Push through your heels to return to the starting position.',
      ],
      imagePath: 'assets/images/squats.jpg',
    ),
  ];

  static List<Exercise> getQuadsExercises() {
    return quadsExercises;
  }
}
