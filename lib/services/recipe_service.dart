import 'package:hive/hive.dart';
import '../models/recipe.dart';

class RecipeService {
  // Call box
  final Box<Recipe> _box = Hive.box<Recipe>('recipes');

  // Create
  void addRecipe(Recipe recipe) {
    _box.add(recipe);
  }

  // Read all
  List<Recipe> getAllRecipes() {
    return _box.values.toList();
  }

  // Read
  Recipe? getRecipe(int index) {
    return _box.get(index);
  }

  // Update
  void updateRecipe(int key, Recipe updatedRecipe) {
    _box.put(key, updatedRecipe);
  }

  // Delete
  void deleteRecipe(int key) {
    _box.delete(key);
  }
}
