import 'package:get_it/get_it.dart';
import 'package:recipes/core/services/db_service.dart';
import 'package:recipes/features/categories/data/datasource/local/categories_database.dart';
import 'package:recipes/features/categories/data/datasource/local/categories_database_impl.dart';
import 'package:recipes/features/categories/data/repository/categories_repository_impl.dart';
import 'package:recipes/features/categories/domain/repository/categories_repository.dart';
import 'package:recipes/features/categories/domain/usecase/get_categories_use_case.dart';
import 'package:recipes/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:recipes/features/mixed_entities/domain/usecase/get_mixed_entities_use_case.dart';
import 'package:recipes/features/mixed_entities/presentation/bloc/entities_bloc.dart';
import 'package:recipes/features/recipes/data/datasource/local/recipes_database.dart';
import 'package:recipes/features/recipes/data/datasource/local/recipes_database_impl.dart';
import 'package:recipes/features/recipes/data/repository/recipe_repoitory_impl.dart';
import 'package:recipes/features/recipes/domain/repository/recipe_repository.dart';
import 'package:recipes/features/recipes/domain/usecase/get_recipes_use_case.dart';
import 'package:recipes/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipes/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:recipes/features/theme/data/repository/theme_repository_impl.dart';
import 'package:recipes/features/theme/domain/repository/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/theme/domain/usecase/get_theme_use_case.dart';
import '../../features/theme/domain/usecase/save_theme_use_case.dart';
import '../../features/theme/presentation/bloc/theme_bloc.dart';

var getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton(await DbService().database);
  getIt.registerSingleton<RecipesDatabase>(
    RecipesDatabaseImpl(database: getIt()),
  );
  getIt.registerSingleton<CategoriesDatabase>(
    CategoriesDatabaseImpl(database: getIt(), parentId: 0),
  );

  getIt.registerSingleton<RecipeRepository>(
    RecipeRepositoryImpl(database: getIt()),
  );
  // getIt.registerSingleton(
  //   GetRecipesUseCase(recipeRepository: getIt(), categoryId: 0),
  // );
  // getIt.registerFactory(
  //   () => RecipeBloc(getRecipesUseCase: getIt(), categoryId: 0),
  // );

  getIt.registerSingleton<CategoriesRepository>(
    CategoriesRepositoryImpl(database: getIt()),
  );
  // getIt.registerSingleton(GetCategoriesUseCase(categoriesRepository: getIt(), parentId: 0));
  // getIt.registerFactory(() => CategoriesBloc(getCategoriesUseCase: getIt(), parentId: 0));

  getIt.registerSingleton(
    GetMixedEntitiesUseCase(
      recipeRepository: getIt(),
      categoriesRepository: getIt(),
    ),
  );
  getIt.registerFactory(
    () => EntitiesBloc(getMixedEntitiesUseCase: getIt()),
  );

  getIt.registerSingleton(await SharedPreferences.getInstance());

  getIt.registerSingleton(ThemeLocalDatasource(sharedPreferences: getIt()));

  getIt.registerSingleton<ThemeRepository>(
    ThemeRepositoryImpl(themeLocalDatasource: getIt()),
  );

  getIt.registerSingleton(GetThemeUseCase(themeRepository: getIt()));
  getIt.registerSingleton(SaveThemeUseCase(themeRepository: getIt()));
  getIt.registerFactory(
    () => ThemeBloc(getThemeUseCase: getIt(), saveThemeUseCase: getIt()),
  );
}
