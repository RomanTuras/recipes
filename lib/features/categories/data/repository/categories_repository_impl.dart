import 'package:recipes/features/categories/data/datasource/local/categories_database.dart';
import 'package:recipes/features/categories/domain/repository/categories_repository.dart';

import '../../domain/models/category.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesDatabase database;

  CategoriesRepositoryImpl({required this.database});

  @override
  Future<List<Category>> getCategories({required int parentId}) async {
    return await database.fetchCategories(parentId: parentId);
  }

  @override
  Future<void> addCategory({required Category category}) async {
    await database.insertCategory(category: category);
  }

  @override
  Future<void> deleteCategory({required int id}) async {
    await database.deleteCategory(id: id);
  }

  @override
  Future<void> updateCategory({required Category category}) async {
    await database.updateCategory(category: category);
  }
}
