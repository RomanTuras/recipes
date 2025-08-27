import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:recipes/core/theme/app_theme.dart';
import 'package:recipes/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:recipes/features/categories/presentation/bloc/categories_events.dart';
import 'package:recipes/features/categories/presentation/bloc/categories_state.dart';
import 'package:recipes/features/mixed_entities/presentation/bloc/entities_events.dart';
import 'package:recipes/features/mixed_entities/presentation/bloc/entities_state.dart';
import 'package:recipes/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipes/features/recipes/presentation/bloc/recipe_events.dart';
import 'package:recipes/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:recipes/features/theme/domain/entity/theme_entity.dart';
import 'package:recipes/features/theme/presentation/bloc/theme_events.dart';
import 'package:recipes/features/theme/presentation/bloc/theme_state.dart';

import 'core/get_it/get_it.dart';
import 'features/categories/domain/models/category.dart';
import 'features/mixed_entities/presentation/bloc/entities_bloc.dart';
import 'features/recipes/domain/models/recipe.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => getIt<ThemeBloc>()..add(GetThemeEvent()),
        ),
        BlocProvider<RecipeBloc>(
          create: (context) => getIt<RecipeBloc>(),
        ),
        BlocProvider<EntitiesBloc>(
          create: (context) =>
              getIt<EntitiesBloc>(),
        ),
      ],

      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.getTheme(
              state.themeEntity?.themeType == ThemeType.dark,
            ),
            home: HomeScreen(),
          );
        },
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _log = Logger();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EntitiesBloc>().add(GetMixedEntitiesEvent(categoryId: 0));
      _log.i("addPostFrameCallback");
    });

    void onCategoryTapHandler(int categoryId) {
      _log.i("catId: $categoryId");
      context.read<EntitiesBloc>().add(GetMixedEntitiesEvent(categoryId: categoryId));
    }

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Recipes"),
            actions: [
              IconButton(
                onPressed: () =>
                    context.read<ThemeBloc>().add(ToggleThemeEvent()),
                icon: Icon(
                  state.themeEntity?.themeType == ThemeType.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            child: Icon(Icons.add),
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<EntitiesBloc, EntitiesState>(
                    builder: (context, state) {
                      final isSuccess = state.status == EntitiesStatus.success;
                      if (!isSuccess) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final items = state.mixedEntities;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (_, index) => items[index] is Category
                            ? CategoryItem(
                                category: items[index] as Category,
                                onTapHandler: onCategoryTapHandler,
                              )
                            : RecipeItem(recipe: items[index] as Recipe),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final Function(int index) onTapHandler;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onTapHandler,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.folder),
      title: Text("id:${category.id}: ${category.title}"),
      onTap: () => onTapHandler(category.id!),
    );
  }
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.receipt_rounded),
      title: Text(recipe.title),
    );
  }
}
