import 'package:recipes/features/recipes/domain/models/recipe.dart';
import 'package:recipes/features/recipes/domain/repository/recipe_repository.dart';

class GetRecipeUseCase {
  final RecipeRepository recipeRepository;

  GetRecipeUseCase({required this.recipeRepository});

  Future<Recipe?> call({required int id}) async {
    return await recipeRepository.getRecipe(id: id);
  }
}