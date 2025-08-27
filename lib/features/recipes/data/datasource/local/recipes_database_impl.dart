import 'dart:math';

import 'package:recipes/features/categories/domain/models/category.dart';
import 'package:recipes/features/recipes/data/datasource/local/recipes_database.dart';
import 'package:recipes/features/recipes/domain/models/recipe.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/constants/database_const.dart';

import 'package:faker/faker.dart';

class RecipesDatabaseImpl implements RecipesDatabase {
  final Database database;

  RecipesDatabaseImpl({required this.database});

  Future<T> withTransaction<T>(
    Future<T> Function(Transaction txn) action,
  ) async {
    return await database.transaction(action);
  }

  Future<void> closeDB() async {
    database.close();
  }

  @override
  Future<Recipe?> fetchRecipe({required int id}) async {
    final result = await database.query(
      recipesTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      Recipe.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<List<Recipe>> fetchRecipes({required int categoryId}) async {
    // await seedDb();

    List<Recipe> recipes = [];
    final result = await database.query(
      recipesTableName,
      where: '$columnCategoryId = ?',
      orderBy: '$columnTitle ASC',
      whereArgs: [categoryId],
    );

    for (final row in result) {
      recipes.add(Recipe.fromMap(row));
    }

    return recipes;
  }

  @override
  Future<void> deleteRecipe({required int id}) async {
    await database.delete(
      recipesTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateRecipe({required Recipe recipe}) async {
    await withTransaction((txn) async {
      final batch = txn.batch();
      batch.update(
        recipesTableName,
        recipe.toMap(),
        where: '$columnId = ?',
        whereArgs: [recipe.id],
      );

      await batch.commit();
    });
  }

  Future<void> seedDb() async {
    await withTransaction((txn) async {
      final batch = txn.batch();

      for (int i = 0; i < 10; i++) {
        var category = Category(title: faker.food.cuisine(), parentId: 0);
        batch.insert(categoryTableName, category.toMap());
      }

      for (int i = 0; i < 10; i++) {
        var category = Category(
          title: faker.food.cuisine(),
          parentId: Random().nextInt(10),
        );
        batch.insert(categoryTableName, category.toMap());
      }

      for (int i = 0; i < 10; i++) {
        var recipe = Recipe(
          title: faker.food.dish(),
          categoryId: 0,
          description: faker.lorem.sentences(5).join(" "),
          ingredients: faker.lorem.words(5).join(", "),
          isFavorite: Random().nextInt(1),
          cookIt: Random().nextInt(1),
          image: "/emulator/0/images/fdf.png",
          date: DateTime.now().toIso8601String(),
        );
        batch.insert(recipesTableName, recipe.toMap());
      }

      for (int i = 0; i < 50; i++) {
        var recipe = Recipe(
          title: faker.food.dish(),
          categoryId: Random().nextInt(20),
          description: faker.lorem.sentences(5).join(" "),
          ingredients: faker.lorem.words(5).join(", "),
          isFavorite: Random().nextInt(1),
          cookIt: Random().nextInt(1),
          image: "/emulator/0/images/fdf.png",
          date: DateTime.now().toIso8601String(),
        );
        batch.insert(recipesTableName, recipe.toMap());
      }

      await batch.commit();
    });
  }
}
