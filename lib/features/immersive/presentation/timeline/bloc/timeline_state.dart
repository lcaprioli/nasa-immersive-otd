import 'package:equatable/equatable.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';

abstract class TimelineState extends Equatable {
  const TimelineState({required this.immersives});
  final Set<ImmersiveEntity> immersives;

  @override
  List<Object?> get props => [immersives];
}

class TimelineInitial extends TimelineState {
  const TimelineInitial() : super(immersives: const {});

  @override
  List<Object?> get props => [immersives];
}

class TimelineInProgress extends TimelineState {
  const TimelineInProgress() : super(immersives: const {});

  @override
  List<Object?> get props => [immersives];
}

class TimelineInSuccess extends TimelineState {
  const TimelineInSuccess({required super.immersives});

  @override
  List<Object?> get props => [immersives];
}

class TimelineError extends TimelineState {
  const TimelineError(this.error) : super(immersives: const {});

  final Exception error;
  @override
  List<Object?> get props => [immersives, error];
}
