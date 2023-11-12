import 'package:equatable/equatable.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';

abstract class TimelineState extends Equatable {
  const TimelineState({
    required this.immersives,
    required this.page,
  });
  final Set<ImmersiveEntity> immersives;
  final int page;

  @override
  List<Object?> get props => [immersives];
}

class TimelineInitial extends TimelineState {
  const TimelineInitial()
      : super(
          immersives: const {},
          page: 0,
        );

  @override
  List<Object?> get props => [immersives];
}

class TimelineInProgress extends TimelineState {
  const TimelineInProgress({required super.page}) : super(immersives: const {});

  @override
  List<Object?> get props => [immersives];
}

class TimelineInSuccess extends TimelineState {
  const TimelineInSuccess({
    required super.immersives,
    required super.page,
  });

  @override
  List<Object?> get props => [immersives];
}

class TimelineError extends TimelineState {
  const TimelineError({
    required super.page,
    required this.error,
  }) : super(immersives: const {});

  final Exception error;
  @override
  List<Object?> get props => [immersives, error];
}
