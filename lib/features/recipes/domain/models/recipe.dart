import 'package:recipes/features/mixed_entities/domain/models/mixed_entity.dart';

import '../../../../core/constants/database_const.dart';

class Recipe extends MixedEntity {
  late int? id;
  late String title;
  String? ingredients;
  String? description;
  late int isFavorite;
  late int cookIt;
  String? image;
  late int categoryId;
  late String? date;

  Recipe({
    this.id,
    required this.title,
    this.description,
    this.ingredients,
    this.isFavorite = 0,
    this.cookIt = 0,
    this.image,
    required this.categoryId,
    this.date,
  });

  Recipe toggleFavorite() {
    return Recipe(
      id: id,
      title: title,
      description: description,
      ingredients: ingredients,
      isFavorite: isFavorite == 0 ? 1 : 0,
      cookIt: cookIt,
      image: image,
      categoryId: categoryId,
      date: date,
    );
  }

  Recipe toggleCookIt() {
    return Recipe(
      id: id,
      title: title,
      description: description,
      ingredients: ingredients,
      isFavorite: isFavorite,
      cookIt: cookIt == 0 ? 1 : 0,
      image: image,
      categoryId: categoryId,
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      columnTitle: title,
      columnIngredients: ingredients,
      columnDescription: description,
      columnIsFavorite: isFavorite,
      columnCookIt: cookIt,
      columnImage: image,
      columnCategoryId: categoryId,
      columnDate: date,
    };
  }

  Recipe.fromMap(Map<String, dynamic> map) {
    id = int.parse(map[columnId].toString());
    title = map[columnTitle].toString();
    description = map[columnIngredients].toString();
    ingredients = map[columnDescription].toString();
    isFavorite = int.parse(map[columnIsFavorite].toString());
    cookIt = int.parse(map[columnCookIt].toString());
    image = map[columnImage].toString();
    categoryId = int.parse(map[columnCategoryId].toString());
    date = map[columnDate].toString();
  }

}
