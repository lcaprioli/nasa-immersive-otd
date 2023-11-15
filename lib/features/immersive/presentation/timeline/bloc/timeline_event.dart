import 'package:equatable/equatable.dart';

abstract class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object?> get props => [];
}

class TimelineStarted extends TimelineEvent {
  const TimelineStarted();

  @override
  List<Object?> get props => [];
}

class TimelinePageChanged extends TimelineEvent {
  const TimelinePageChanged(this.page);

  final int page;
  @override
  List<Object?> get props => [page];
}

class TimelinePageRefreshed extends TimelineEvent {
  const TimelinePageRefreshed();

  @override
  List<Object?> get props => [];
}
