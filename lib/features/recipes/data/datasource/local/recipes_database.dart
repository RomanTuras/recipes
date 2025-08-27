import 'package:recipes/features/recipes/domain/models/recipe.dart';

abstract class RecipesDatabase {
  Future<List<Recipe>> fetchRecipes({required int categoryId});

  Future<Recipe?> fetchRecipe({required int id});

  Future<void> deleteRecipe({required int id});

  Future<void> updateRecipe({required Recipe recipe});
}