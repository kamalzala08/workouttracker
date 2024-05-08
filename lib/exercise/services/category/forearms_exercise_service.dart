import '../exercise.dart'; // Import the Exercise class

class ForearmsExerciseService {
  static final List<Exercise> forearmsExercises = [
    Exercise(
      exerciseId: '009',
      name: 'Wrist Curls',
      level: 'Beginner',
      description:
          'A basic exercise to strengthen the forearm muscles, using a barbell or dumbbells.',
      steps: [
        'Sit on a bench and rest your forearms on your thighs, palms facing upward, holding a barbell or dumbbells.',
        'Curl your wrists upward, then slowly lower them back down.',
      ],
      imagePath: 'assets/images/wrist_curls.jpg',
    ),
  ];

  static List<Exercise> getForearmsExercises() {
    return forearmsExercises;
  }
}
