import '../exercise.dart'; // Import the Exercise class

class BicepsExerciseService {
  static final List<Exercise> bicepsExercises = [
    Exercise(
      exerciseId: '008',
      name: 'Bicep Curl',
      level: 'Beginner',
      description: 'A basic exercise that targets the biceps using dumbbells.',
      steps: [
        'Stand with your arms by your sides, holding a dumbbell in each hand.',
        'Curl the weights towards your shoulders, then slowly lower them.',
      ],
      imagePath: 'assets/images/bicep_curl.jpg',
    ),
  ];

  static List<Exercise> getBicepsExercises() {
    return bicepsExercises;
  }
}
