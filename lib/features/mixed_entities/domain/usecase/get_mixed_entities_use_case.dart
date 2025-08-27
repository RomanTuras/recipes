import 'package:recipes/features/categories/domain/repository/categories_repository.dart';
import 'package:recipes/features/mixed_entities/domain/models/mixed_entity.dart';

import '../../../recipes/domain/repository/recipe_repository.dart';

class GetMixedEntitiesUseCase {
  final RecipeRepository recipeRepository;
  final CategoriesRepository categoriesRepository;

  GetMixedEntitiesUseCase({
    required this.recipeRepository,
    required this.categoriesRepository
  });

  Future<List<MixedEntity>> call({required int categoryId}) async {
    final categories = await categoriesRepository.getCategories(parentId: categoryId);
    final recipes = await recipeRepository.getRecipes(categoryId: categoryId);

    final List<MixedEntity> mixedEntities = List.from(categories)..addAll(recipes as Iterable<MixedEntity>);

    return mixedEntities;
  }
}
