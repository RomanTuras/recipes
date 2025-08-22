import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/theme/app_theme.dart';
import 'package:recipes/features/theme/domain/entity/theme_entity.dart';
import 'package:recipes/features/theme/presentation/bloc/theme_events.dart';
import 'package:recipes/features/theme/presentation/bloc/theme_state.dart';

import 'core/get_it/get_it.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(BlocProvider(
      create: (context) => 
      getIt<ThemeBloc>()
        ..add(GetThemeEvent()), 
    child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.getTheme(state.themeEntity?.themeType == ThemeType.dark),
            home: HomeScreen(),
          );
        })
  ),);
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Recipes"),
            actions: [
              IconButton(
                  onPressed: () => context.read<ThemeBloc>().add(ToggleThemeEvent()),
                  icon: Icon(state.themeEntity?.themeType == ThemeType.dark ? Icons.light_mode : Icons.dark_mode))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () { context.read<ThemeBloc>().add(ToggleThemeEvent()); },
            child: Icon(Icons.add),
          ),
        );
      }
    );
  }
}


