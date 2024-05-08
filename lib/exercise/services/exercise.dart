
class Exercise {
  final String exerciseId ;
  final String name;
  final String level;
  final String description;
  final List<String> steps;
  final String imagePath; // For storing the image location

  Exercise({
    required this.exerciseId,
    required this.name,
    required this.level,
    required this.description,
    required this.steps,
    required this.imagePath,
  });
}
