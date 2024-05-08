import '../exercise.dart'; // Import the Exercise class

class LatsExerciseService {
  static final List<Exercise> latsExercises = [
    Exercise(
      exerciseId: '012',
      name: 'Lat Pulldown',
      level: 'Intermediate',
      description:
          'An exercise targeting the latissimus dorsi (lats) using a cable machine.',
      steps: [
        'Sit at a lat pulldown machine and grip the bar with a wide grip.',
        'Pull the bar down to your chest, then slowly release it back up.',
      ],
      imagePath: 'assets/images/lat_pulldown.jpg',
    ),
  ];

  static List<Exercise> getLatsExercises() {
    return latsExercises;
  }
}
