import 'package:recipes/features/recipes/domain/models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes({required int categoryId});

  Future<Recipe?> getRecipe({required int id});

  Future<void> deleteRecipe({required int id});

  Future<void> updateRecipe({required Recipe recipe});
}