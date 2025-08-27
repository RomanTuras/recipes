abstract class MixedEntitiesEvent {}

class GetMixedEntitiesEvent extends MixedEntitiesEvent {
  final int categoryId;

  GetMixedEntitiesEvent({required this.categoryId});
}