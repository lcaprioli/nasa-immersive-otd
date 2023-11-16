import 'package:equatable/equatable.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/features/immersive/domain/exceptions/exceptions.dart';

sealed class TimelineState extends Equatable {
  const TimelineState({
    required this.immersives,
    required this.page,
  });
  final Set<ImmersiveEntity> immersives;
  final int page;

  @override
  List<Object?> get props => [immersives, page];
}

class TimelineInitialState extends TimelineState {
  const TimelineInitialState()
      : super(
          immersives: const {},
          page: 0,
        );

  @override
  List<Object?> get props => [immersives, page];
}

class TimelineInProgressState extends TimelineState {
  const TimelineInProgressState({required super.page})
      : super(
          immersives: const {},
        );

  @override
  List<Object?> get props => [immersives, page];
}

class TimelineSuccessState extends TimelineState {
  const TimelineSuccessState({
    required super.immersives,
    required super.page,
  });

  @override
  List<Object?> get props => [immersives, page];
}

class TimelineErrorState extends TimelineState {
  const TimelineErrorState({
    required super.page,
    required this.error,
  }) : super(immersives: const {});

  final CustomException error;

  @override
  List<Object?> get props => [immersives, page, error];
}
