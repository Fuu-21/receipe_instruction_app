import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recipe.dart';
import 'recipe_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipe App',
        home: RecipeListScreen(),
      ),
    );
  }
}

class RecipeListScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Recipe Title'),
                ),
                TextField(
                  controller: _ingredientsController,
                  decoration: InputDecoration(labelText: 'Ingredients'),
                ),
                TextField(
                  controller: _instructionsController,
                  decoration: InputDecoration(labelText: 'Instructions'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _ingredientsController.text.isNotEmpty &&
                        _instructionsController.text.isNotEmpty) {
                      var ingredients = _ingredientsController.text.split('\n');
                      var instructions = _instructionsController.text.split('\n');

                      recipeProvider.addRecipe(
                        Recipe(
                          title: _titleController.text,
                          ingredients: ingredients,
                          instructions: instructions,
                        ),
                      );

                      _titleController.clear();
                      _ingredientsController.clear();
                      _instructionsController.clear();
                    }
                  },
                  child: Text('Add Recipe'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipeProvider.recipes.length,
              itemBuilder: (context, index) {
                var recipe = recipeProvider.recipes[index];
                return ListTile(
                  title: Text(recipe.title),
                  subtitle: Text('Ingredients: ${recipe.ingredients.length}'),
                  onTap: () {

                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      recipeProvider.deleteRecipe(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
