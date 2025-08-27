import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/features/recipes/domain/usecase/get_recipes_use_case.dart';
import 'package:recipes/features/recipes/presentation/bloc/recipe_events.dart';
import 'package:recipes/features/recipes/presentation/bloc/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipeUseCase getRecipeUseCase;

  RecipeBloc({required this.getRecipeUseCase}) : super(RecipeState.initial()) {
    on<GetRecipeEvent>(onGetRecipeEvent);
  }

  Future<void> onGetRecipeEvent(GetRecipeEvent event, Emitter<RecipeState> emit) async {
    emit(state.copyWith(status: RecipeStatus.loading));

    try {
      var result = await getRecipeUseCase(id: event.id);
      emit(state.copyWith(status: RecipeStatus.success, recipe: result));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.error, errorMessage: e.toString()));
    }
  }

}