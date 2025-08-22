import 'package:recipes/features/theme/domain/entity/theme_entity.dart';

abstract class ThemeRepository {
  Future<ThemeEntity> getTheme();

  Future<void> saveTheme(ThemeEntity theme);
}