import 'package:hive/hive.dart';

part 'recipe.g.dart'; // generated adapter -> source GPT

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<String> ingredients;

  @HiveField(3)
  String steps;

  @HiveField(4)
  String? imagePath;

  @HiveField(5)
  DateTime createdAt;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.steps,
    this.imagePath,
    required this.createdAt,
  });
}
