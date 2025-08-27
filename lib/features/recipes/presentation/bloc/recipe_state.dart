import '../../domain/models/recipe.dart';

enum RecipeStatus { initial, loading, success, error }

class RecipeState {
  final RecipeStatus status;
  final String? errorMessage;

  final Recipe? recipe;

  RecipeState._({required this.status, this.errorMessage, this.recipe});

  factory RecipeState.initial() => RecipeState._(status: RecipeStatus.initial);

  RecipeState copyWith({RecipeStatus? status, String? errorMessage, Recipe? recipe}) =>
      RecipeState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          recipe: recipe ?? this.recipe
      );
}
