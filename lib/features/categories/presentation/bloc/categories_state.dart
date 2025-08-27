// import 'package:recipes/features/categories/domain/models/category.dart';
//
// enum CategoriesStatus { initial, loading, success, error }
//
// class CategoriesState {
//   final CategoriesStatus status;
//   final String? errorMessage;
//
//   final List<Category> categories;
//
//   CategoriesState._({required this.status, this.errorMessage, required this.categories,});
//
//   factory CategoriesState.initial() => CategoriesState._(status: CategoriesStatus.initial, categories: []);
//
//   CategoriesState copyWith({CategoriesStatus? status, String? errorMessage, Category? category, required List<Category> categories}) =>
//       CategoriesState._(
//           status: status ?? this.status,
//           errorMessage: errorMessage ?? this.errorMessage,
//           categories: categories
//       );
// }
