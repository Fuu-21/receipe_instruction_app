import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void deleteRecipe(int index) {
    _recipes.removeAt(index);
    notifyListeners();
  }
}
