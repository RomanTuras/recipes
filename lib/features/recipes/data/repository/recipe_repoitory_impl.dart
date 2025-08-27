import 'package:recipes/features/recipes/domain/models/recipe.dart';
import 'package:recipes/features/recipes/domain/repository/recipe_repository.dart';

import '../datasource/local/recipes_database.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipesDatabase database;

  RecipeRepositoryImpl({required this.database});

  @override
  Future<List<Recipe>> getRecipes({required int categoryId}) async {
    return await database.fetchRecipes(categoryId: categoryId);
  }

  @override
  Future<Recipe?> getRecipe({required int id}) async {
    return await database.fetchRecipe(id: id);
  }

  @override
  Future<void> deleteRecipe({required int id}) async {
    return await database.deleteRecipe(id: id);
  }

  @override
  Future<void> updateRecipe({required Recipe recipe}) async {
    return await database.updateRecipe(recipe: recipe);
  }

}