import 'package:recipes/features/theme/domain/entity/theme_entity.dart';
import 'package:recipes/features/theme/domain/repository/theme_repository.dart';

import '../datasource/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<ThemeEntity> getTheme() async {
    return await themeLocalDatasource.getTheme();
  }

  @override
  Future<void> saveTheme(ThemeEntity theme) async {
    await themeLocalDatasource.saveTheme(theme);
  }
}