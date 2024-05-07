// chest_exercise_service.dart
import 'package:flutter/material.dart';

// Service for Chest Exercises
class ChestExerciseService {
  static final List<Map<String, dynamic>> chestExercises = [
    {
      'name': 'Bench Press',
      'level': 'Intermediate',
      'description':
          'A foundational chest exercise involving a barbell press on a flat bench.',
      'steps': [
        'Lie flat on a bench with feet on the ground.',
        'Grip the barbell with hands slightly wider than shoulder-width.',
        'Lift the barbell off the rack and slowly lower it to your chest.',
        'Press the barbell back up until arms are fully extended.',
      ],
      'image': 'assets/images/bench_press.png', // Path to the exercise image
    },
    {
      'name': 'Push-ups',
      'level': 'Beginner',
      'description':
          'A classic bodyweight exercise that works the chest, triceps, and shoulders.',
      'steps': [
        'Start in a plank position with arms straight.',
        'Lower your body toward the ground.',
        'Push back up to the starting position.',
      ],
      'image': 'assets/images/push_ups.png', // Image path
    },
    {
      'name': 'Chest Fly',
      'level': 'Intermediate',
      'description':
          'An exercise that targets the chest through a fly motion using dumbbells.',
      'steps': [
        'Lie flat on a bench with a dumbbell in each hand.',
        'Extend your arms above your chest.',
        'Slowly lower the dumbbells out to your sides.',
        'Bring them back to the starting position.',
      ],
      'image': 'assets/images/chest_fly.png',
    },
    {
      'name': 'Incline Bench Press',
      'level': 'Intermediate',
      'description': 'A bench press variant that targets the upper chest.',
      'steps': [
        'Set the bench to an incline position.',
        'Grip the barbell with hands slightly wider than shoulder-width.',
        'Lift the barbell off the rack and lower it to your chest.',
        'Press the barbell back up to the starting position.',
      ],
      'image': 'assets/images/incline_bench_press.png',
    },
    {
      'name': 'Decline Bench Press',
      'level': 'Expert',
      'description': 'A bench press variant that targets the lower chest.',
      'steps': [
        'Set the bench to a decline position.',
        'Grip the barbell with hands slightly wider than shoulder-width.',
        'Lift the barbell off the rack and lower it to your chest.',
        'Press the barbell back up to the starting position.',
      ],
      'image': 'assets/images/decline_bench_press.png',
    },
    {
      'name': 'Cable Crossover',
      'level': 'Expert',
      'description':
          'A chest exercise using cable machines for a crossover motion.',
      'steps': [
        'Stand between two cable machines with handles.',
        'Grab the handles and extend your arms out to the sides.',
        'Bring the handles together in front of you.',
        'Slowly return to the starting position.',
      ],
      'image': 'assets/images/cable_crossover.png',
    },
  ];

  static List<Map<String, dynamic>> getAllChestExercises() {
    return chestExercises;
  }
}
