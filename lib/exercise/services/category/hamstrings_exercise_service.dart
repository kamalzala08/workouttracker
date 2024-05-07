import '../exercise.dart'; // Import the Exercise class

class HamstringsExerciseService {
  static final List<Exercise> hamstringsExercises = [
    Exercise(
      name: 'Leg Curl',
      level: 'Beginner',
      description:
          'An exercise to strengthen the hamstring muscles using a leg curl machine.',
      steps: [
        'Lie face down on a leg curl machine.',
        'Curl your legs up towards your buttocks, then slowly lower them.',
      ],
      imagePath: 'assets/images/leg_curl.jpg',
    ),
  ];

  static List<Exercise> getHamstringsExercises() {
    return hamstringsExercises;
  }
}
