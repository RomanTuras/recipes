import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/features/theme/domain/entity/theme_entity.dart';
import 'package:recipes/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:recipes/features/theme/domain/usecase/save_theme_use_case.dart';
import 'package:recipes/features/theme/presentation/bloc/theme_events.dart';
import 'package:recipes/features/theme/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({required this.getThemeUseCase, required this.saveThemeUseCase}) : super(ThemeState.initial()) {
    on<GetThemeEvent>(onGetThemeEvent);
    on<ToggleThemeEvent>(onToggleThemeEvent);
  }

  Future<void> onGetThemeEvent(GetThemeEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: ThemeStatus.loading));

    try {
      var result = await getThemeUseCase();
      emit(state.copyWith(status: ThemeStatus.success, themeEntity: result));
    } catch (e) {
      emit(state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> onToggleThemeEvent(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    if(state.themeEntity != null) {
      var newThemeType = state.themeEntity!.themeType == ThemeType.dark ? ThemeType.light : ThemeType.dark;
      var newThemeEntity = ThemeEntity(themeType: newThemeType);

      try {
        await saveThemeUseCase(newThemeEntity);
        emit(state.copyWith(status: ThemeStatus.success, themeEntity: newThemeEntity));
      } catch (e) {
        emit(state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()));
      }
    }

  }
}