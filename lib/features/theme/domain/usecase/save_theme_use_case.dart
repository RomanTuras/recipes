import 'package:recipes/features/theme/domain/repository/theme_repository.dart';

import '../entity/theme_entity.dart';

class SaveThemeUseCase {
  final ThemeRepository themeRepository;

  SaveThemeUseCase({required this.themeRepository});

  Future<void> call(ThemeEntity themeEntity) async {
    await themeRepository.saveTheme(themeEntity);
  }
}