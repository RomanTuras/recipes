import 'package:recipes/features/mixed_entities/domain/models/mixed_entity.dart';
import 'package:equatable/equatable.dart';

enum EntitiesStatus { initial, loading, success, error }

class EntitiesState extends Equatable {
  final EntitiesStatus status;
  final String? errorMessage;

  final List<MixedEntity> mixedEntities;

  const EntitiesState._({required this.status, this.errorMessage, required this.mixedEntities,});

  factory EntitiesState.initial() => EntitiesState._(status: EntitiesStatus.initial, mixedEntities: []);

  EntitiesState copyWith({EntitiesStatus? status, String? errorMessage, List<MixedEntity>? mixedEntities}) =>
      EntitiesState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          mixedEntities: mixedEntities ?? this.mixedEntities
      );

  @override
  List<Object?> get props => [status, errorMessage, mixedEntities];
}