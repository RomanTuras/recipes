import 'package:logger/logger.dart';
import 'package:recipes/features/categories/data/datasource/local/categories_database.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/constants/database_const.dart';
import '../../../domain/models/category.dart';

class CategoriesDatabaseImpl implements CategoriesDatabase {
  final Database database;
  final int parentId;

  CategoriesDatabaseImpl({required this.database, required this.parentId});

  final _log = Logger();

  Future<T> withTransaction<T>(
    Future<T> Function(Transaction txn) action,
  ) async {
    return await database.transaction(action);
  }

  Future<void> closeDB() async {
    database.close();
  }

  @override
  Future<List<Category>> fetchCategories({required int parentId}) async {
    List<Category> categories = [];

    final result = await database.query(
      categoryTableName,
      where: '$columnParentCategoryId = ?',
      orderBy: '$columnTitle ASC',
      whereArgs: [parentId],
    );

    for (final row in result) {
      categories.add(Category.fromMap(row));
    }

    return categories;
  }

  @override
  Future<void> insertCategory({required Category category}) async {
    await withTransaction((txn) async {
      final batch = txn.batch();
      batch.insert(categoryTableName, category.toMap());

      await batch.commit();
    });
  }

  @override
  Future<void> deleteCategory({required int id}) async {
    await database.delete(
      categoryTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateCategory({required Category category}) async {
    await withTransaction((txn) async {
      final batch = txn.batch();
      batch.update(
        categoryTableName,
        category.toMap(),
        where: '$columnId = ?',
        whereArgs: [category.id],
      );

      await batch.commit();
    });
  }
}
