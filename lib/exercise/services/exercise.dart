
class Exercise {
  final String name;
  final String level;
  final String description;
  final List<String> steps;
  final String imagePath; // For storing the image location

  Exercise({
    required this.name,
    required this.level,
    required this.description,
    required this.steps,
    required this.imagePath,
  });
}
