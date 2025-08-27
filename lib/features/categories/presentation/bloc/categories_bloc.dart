// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recipes/features/categories/domain/usecase/get_categories_use_case.dart';
// import 'package:recipes/features/categories/presentation/bloc/categories_events.dart';
// import 'package:recipes/features/categories/presentation/bloc/categories_state.dart';
//
// class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
//   final GetCategoriesUseCase getCategoriesUseCase;
//   final int parentId;
//
//
//   CategoriesBloc({required this.getCategoriesUseCase, required this.parentId}) : super(CategoriesState.initial()) {
//     on<GetCategoriesEvent>(onCategoriesEvent);
//   }
//
//   Future<void> onCategoriesEvent(GetCategoriesEvent event, Emitter<CategoriesState> emit) async {
//     emit(state.copyWith(status: CategoriesStatus.loading, categories: []));
//
//     try {
//       var result = await getCategoriesUseCase(parentId: parentId);
//       emit(state.copyWith(status: CategoriesStatus.success, categories: result));
//     } catch (e) {
//       emit(state.copyWith(status: CategoriesStatus.error, errorMessage: e.toString(), categories: []));
//     }
//   }
//
// }