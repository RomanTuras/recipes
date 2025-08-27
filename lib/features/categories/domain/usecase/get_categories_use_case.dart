import 'package:recipes/features/categories/domain/models/category.dart';
import 'package:recipes/features/categories/domain/repository/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository categoriesRepository;
  final int parentId;

  GetCategoriesUseCase({required this.categoriesRepository, required this.parentId});

  Future<List<Category>> call({required int parentId}) async {
    return await categoriesRepository.getCategories(parentId: parentId);
  }
}