import 'package:recipes/features/categories/domain/models/category.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getCategories({required int parentId});

  Future<void> addCategory({required Category category});

  Future<void> deleteCategory({required int id});

  Future<void> updateCategory({required Category category});
}