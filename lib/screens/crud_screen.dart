import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> _recipes = [];

  final titleController = TextEditingController();
  final ingredientsController = TextEditingController();
  final stepsController = TextEditingController();

  Recipe? _selectedRecipe;

  void _refreshData() {
    setState(() {
      _recipes = _recipeService.getAllRecipes();
    });
  }

  void _addData() {
    final id = DateTime.now().millisecondsSinceEpoch;
    final title = titleController.text.trim();
    final ingredients =
        ingredientsController.text.split(',').map((e) => e.trim()).toList();
    final steps = stepsController.text.trim();

    final newRecipe = Recipe(
      id: id,
      title: title,
      ingredients: ingredients,
      steps: steps,
      createdAt: DateTime.now(),
    );

    _recipeService.addRecipe(newRecipe);
    _clearForm();
    _refreshData();
  }

  void _updateData() {
    if (_selectedRecipe == null) return;

    final title = titleController.text.trim();
    final ingredients =
        ingredientsController.text.split(',').map((e) => e.trim()).toList();
    final steps = stepsController.text.trim();

    final updated = Recipe(
      id: _selectedRecipe!.id,
      title: title,
      ingredients: ingredients,
      steps: steps,
      createdAt: _selectedRecipe!.createdAt,
    );

    _recipeService.updateRecipe(_selectedRecipe!.key as int, updated);
    _clearForm();
    _refreshData();
  }

  void _deleteData(int key) {
    _recipeService.deleteRecipe(key);
    _refreshData();
  }

  void _fillForm(Recipe recipe) {
    setState(() {
      _selectedRecipe = recipe;
      titleController.text = recipe.title;
      ingredientsController.text = recipe.ingredients.join(', ');
      stepsController.text = recipe.steps;
    });
  }

  void _clearForm() {
    setState(() {
      _selectedRecipe = null;
      titleController.clear();
      ingredientsController.clear();
      stepsController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void dispose() {
    titleController.dispose();
    ingredientsController.dispose();
    stepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _selectedRecipe != null;

    return Scaffold(
      appBar: AppBar(title: Text('CRUD Resep')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(
                labelText: 'Bahan (pisahkan dengan koma)',
              ),
            ),
            TextField(
              controller: stepsController,
              decoration: InputDecoration(labelText: 'Langkah-langkah'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: isEditing ? _updateData : _addData,
                  child: Text(isEditing ? 'Update' : 'Tambah'),
                ),
                const SizedBox(width: 10),
                if (isEditing)
                  ElevatedButton(
                    onPressed: _clearForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Batal'),
                  ),
              ],
            ),
            const Divider(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return Card(
                    child: ListTile(
                      title: Text(recipe.title),
                      subtitle: Text('Bahan: ${recipe.ingredients.join(', ')}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _fillForm(recipe),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteData(recipe.key as int),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
