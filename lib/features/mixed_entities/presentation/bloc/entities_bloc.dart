import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/features/mixed_entities/presentation/bloc/entities_events.dart';
import 'package:recipes/features/mixed_entities/presentation/bloc/entities_state.dart';
import 'package:recipes/features/mixed_entities/domain/usecase/get_mixed_entities_use_case.dart';

class EntitiesBloc extends Bloc<MixedEntitiesEvent, EntitiesState> {
  final GetMixedEntitiesUseCase getMixedEntitiesUseCase;

  EntitiesBloc({required this.getMixedEntitiesUseCase}) : super(EntitiesState.initial()) {
    on<GetMixedEntitiesEvent>(onGetMixedEntitiesEvent);
  }

  Future<void> onGetMixedEntitiesEvent(GetMixedEntitiesEvent event, Emitter<EntitiesState> emit) async {
    emit(state.copyWith(status: EntitiesStatus.loading));

    try {
      var items = await getMixedEntitiesUseCase(categoryId: event.categoryId);
      emit(state.copyWith(status: EntitiesStatus.success, mixedEntities: List.from(items)));
    } catch (e) {
      emit(state.copyWith(status: EntitiesStatus.error, errorMessage: e.toString(), mixedEntities: []));
    }
  }

}