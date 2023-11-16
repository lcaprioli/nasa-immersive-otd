import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/data/repositories/immersive_repository.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/features/immersive/domain/exceptions/exceptions.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_event.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc({required ImmersiveRepository repository})
      : _repository = repository,
        super(const TimelineInitialState()) {
    on<TimelineStarted>(_onStarted);
    on<TimelinePageChanged>(_onPageChanged);
    on<TimelinePageRefreshed>(_onPageRefreshed);
  }

  final ImmersiveRepository _repository;

  final Set<Set<ImmersiveEntity>> _collection = {};

  static const _kInterval = 3;

  int _page = 0;

  DateTime get _initialDate => DateTime.now().subtract(
        Duration(days: ((_page + 1) * (_kInterval)) - 1),
      );
  DateTime get _endDate => DateTime.now().subtract(
        Duration(days: _page * _kInterval),
      );

  _onStarted(TimelineStarted event, Emitter emit) async => _fetch(0, emit);

  _onPageChanged(TimelinePageChanged event, Emitter emit) async =>
      _fetch(event.page, emit);

  _onPageRefreshed(TimelinePageRefreshed event, Emitter emit) async =>
      _fetch(_page, emit);

  void _fetch(int page, Emitter emit) async {
    try {
      _page = page;

      if (_collection.elementAtOrNull(_page) == null) {
        emit(TimelineInProgressState(page: _page));
        final immersives = await _repository.get(_initialDate, _endDate);
        _collection.add(immersives);
      }
      emit(TimelineSuccessState(
        immersives: _collection.elementAt(_page),
        page: _page,
      ));
    } on CustomException catch (e) {
      emit(TimelineErrorState(page: _page, error: e));
    }
  }

  void init() => add(const TimelineStarted());
  void prev() => add(TimelinePageChanged(_page + 1));
  void next() => add(TimelinePageChanged(_page - 1));

  void refresh() => add(const TimelinePageRefreshed());
}
