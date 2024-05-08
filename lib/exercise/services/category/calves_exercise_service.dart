import '../exercise.dart'; // Import the Exercise class

class CalvesExerciseService {
  static final List<Exercise> calvesExercises = [
    Exercise(
      exerciseId: '009',
      name: 'Calf Raises',
      level: 'Beginner',
      description:
          'An exercise to strengthen the calf muscles by raising the heels.',
      steps: [
        'Stand with your feet shoulder-width apart.',
        'Slowly raise your heels, then lower them back down.',
      ],
      imagePath: 'assets/images/calf_raises.jpg',
    ),
  ];

  static List<Exercise> getCalvesExercises() {
    return calvesExercises;
  }
}
