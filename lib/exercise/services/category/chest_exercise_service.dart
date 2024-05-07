import '../exercise.dart'; // Import the Exercise class

class ChestExerciseService {
  static final List<Exercise> chestExercises = [
    Exercise(
      name: 'Bench Press',
      level: 'Intermediate',
      description:
          'A classic chest exercise that helps build mass and strength in the chest muscles. It also involves the triceps and shoulders.',
      steps: [
        'Lie on a flat bench with your feet flat on the floor.',
        'Grip the barbell slightly wider than shoulder-width.',
        'Lower the barbell to your chest, then press it back up to the starting position.',
      ],
      imagePath: 'assets/images/exercises/chest/bench_press.png',
    ),
    Exercise(
      name: 'Push-ups',
      level: 'Beginner',
      description:
          'A basic bodyweight exercise that targets the chest and triceps.',
      steps: [
        'Place your hands slightly wider than shoulder-width.',
        'Keep your body in a straight line from head to heels.',
        'Lower your body until your chest almost touches the floor, then push back to the starting position.',
      ],
      imagePath: 'assets/images/exercises/chest/push_ups.png',
    ),
    Exercise(
      name: 'Chest Fly',
      level: 'Intermediate',
      description:
          'An exercise that isolates the chest muscles, focusing on the pectorals.',
      steps: [
        'Lie on a flat bench with dumbbells in each hand.',
        'Extend your arms straight above your chest.',
        'Lower your arms out to the sides, keeping a slight bend in your elbows.',
        'Bring the dumbbells back up to the starting position.',
      ],
      imagePath: 'assets/images/exercises/chest/chest_fly.png',
    ),
    Exercise(
      name: 'Incline Bench Press',
      level: 'Intermediate',
      description: 'Targets the upper part of the chest and shoulders.',
      steps: [
        'Set the bench to a 30-45 degree angle.',
        'Grip the barbell and lower it to your upper chest.',
        'Press it back to the starting position.',
      ],
      imagePath: 'assets/images/exercises/chest/incline_bench_press.png',
    ),
    Exercise(
      name: 'Decline Bench Press',
      level: 'Expert',
      description:
          'Targets the lower part of the chest and requires more control.',
      steps: [
        'Set the bench to a decline angle.',
        'Grip the barbell and lower it to your lower chest.',
        'Press it back up to the starting position.',
      ],
      imagePath: 'assets/images/exercises/chest/decline_bench_press.png',
    ),
    Exercise(
      name: 'Cable Crossover',
      level: 'Expert',
      description:
          'An isolation exercise that works the chest muscles using cables.',
      steps: [
        'Set the cables to a high position.',
        'Pull the cables down and across your body, keeping a slight bend in your elbows.',
        'Return to the starting position with control.',
      ],
      imagePath: 'assets/images/exercises/chest/cable_cross.png',
    ),
  ];

  static List<Exercise> getChestExercises() {
    return chestExercises;
  }
}
