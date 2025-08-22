import 'package:get_it/get_it.dart';
import 'package:recipes/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:recipes/features/theme/data/repository/theme_repository_impl.dart';
import 'package:recipes/features/theme/domain/repository/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/theme/domain/usecase/get_theme_use_case.dart';
import '../../features/theme/domain/usecase/save_theme_use_case.dart';
import '../../features/theme/presentation/bloc/theme_bloc.dart';

var getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton(await SharedPreferences.getInstance());

  getIt.registerSingleton(ThemeLocalDatasource(sharedPreferences: getIt()));

  getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(themeLocalDatasource: getIt()));

  getIt.registerSingleton(GetThemeUseCase(themeRepository: getIt()));
  getIt.registerSingleton(SaveThemeUseCase(themeRepository: getIt()));
  getIt.registerFactory(() => ThemeBloc(getThemeUseCase: getIt(), saveThemeUseCase: getIt())) ;
}