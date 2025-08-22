import 'package:recipes/features/theme/domain/repository/theme_repository.dart';

import '../entity/theme_entity.dart';

class GetThemeUseCase {
  final ThemeRepository themeRepository;

  GetThemeUseCase({required this.themeRepository});

  Future<ThemeEntity> call() async {
    return await themeRepository.getTheme();
  }
}