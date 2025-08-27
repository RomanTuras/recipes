abstract class RecipeEvent {}

class GetRecipeEvent extends RecipeEvent {
  final int id;

  GetRecipeEvent({required this.id});
}