import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/data/repositories/immersive_repository.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_event.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc({required ImmersiveRepository repository})
      : _repository = repository,
        super(const TimelineInitial()) {
    on<TimelineStarted>(_onStarted);
    on<TimelinePageChanged>(_onPageChanged);
  }

  final ImmersiveRepository _repository;

  final Set<Set<ImmersiveEntity>> _collection = {};

  static const _interval = 5;

  int _page = 0;

  DateTime get _initialDate => DateTime.now().subtract(
        Duration(days: ((_page + 1) * (_interval)) - 1),
      );
  DateTime get _endDate => DateTime.now().subtract(
        Duration(days: _page * _interval),
      );

  _onStarted(TimelineStarted event, Emitter emit) async {
    try {
      emit(TimelineInProgress(page: _page));
      final immersives = await _repository.get(_initialDate, _endDate);
      _collection.add(immersives);
      emit(TimelineSuccess(
        immersives: immersives,
        page: _page,
      ));
    } catch (e) {
      emit(TimelineError(page: _page, message: e.toString()));
    }
  }

  _onPageChanged(TimelinePageChanged event, Emitter emit) async {
    try {
      _page = event.page;

      if (_collection.elementAtOrNull(_page) == null) {
        emit(TimelineInProgress(page: _page));
        final immersives = await _repository.get(_initialDate, _endDate);
        _collection.add(immersives);
      }
      emit(TimelineSuccess(
        immersives: _collection.elementAt(_page),
        page: _page,
      ));
    } catch (e) {
      emit(TimelineError(page: _page, message: e.toString()));
    }
  }

  void init() => add(const TimelineStarted());
  void prev() => add(TimelinePageChanged(_page + 1));
  void next() => add(TimelinePageChanged(_page - 1));
}
