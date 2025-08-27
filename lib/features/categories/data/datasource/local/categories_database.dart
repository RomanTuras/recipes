import '../../../domain/models/category.dart';

abstract class CategoriesDatabase {
  Future<List<Category>> fetchCategories({required int parentId});

  Future<void> insertCategory({required Category category});

  Future<void> deleteCategory({required int id});

  Future<void> updateCategory({required Category category});
}
