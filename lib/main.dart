import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:recipes/core/routing/router.dart';
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
            home: MyApp(),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    _router = router(getIt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

