import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/features/immersive/data/repositories/immersive_repository.dart';
import 'package:nasa_immersive_od/features/immersive/domain/exceptions/exceptions.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_event.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_state.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockImmersiveRepository extends Mock implements ImmersiveRepository {}

void main() {
  late TimelineBloc bloc;
  late MockImmersiveRepository mockImmersiveRepository;

  setUp(() {
    mockImmersiveRepository = MockImmersiveRepository();

    bloc = TimelineBloc(
      repository: mockImmersiveRepository,
    );
  });
  final tImmersiveList = {
    ImmersiveDto.fromJson(json.decode(fixture('apod_item_2017-07-08.json'))),
    ImmersiveDto.fromJson(json.decode(fixture('apod_item_2017-07-09.json'))),
    ImmersiveDto.fromJson(json.decode(fixture('apod_item_2017-07-10.json'))),
  };
  test('Initial state should be TimelineInitial', () {
    expect(bloc.state, equals(const TimelineInitial()));
  });

  test(
    'should get data from the repository',
    () async {
      when(() => mockImmersiveRepository.get(any(), any()))
          .thenAnswer((_) async => tImmersiveList);

      bloc.add(const TimelineStarted());
      await untilCalled(() => mockImmersiveRepository.get(any(), any()));
      verify(() => mockImmersiveRepository.get(any(), any()));
    },
  );

  test(
    'should emit [InProgress, Success] when data is gotten successfully',
    () async {
      when(() => mockImmersiveRepository.get(any(), any()))
          .thenAnswer((_) async => tImmersiveList);
      final expected = [
        const TimelineInProgress(page: 0),
        TimelineSuccess(immersives: tImmersiveList, page: 0),
      ];
      bloc.add(const TimelineStarted());
      expectLater(bloc.stream, emitsInOrder(expected));
    },
  );
  test(
    'should emit [InProgress, Error] when getting data fails',
    () async {
      final tException = ServerException();
      when(() => mockImmersiveRepository.get(any(), any()))
          .thenAnswer((_) async => throw tException);

      final expected = [
        const TimelineInProgress(page: 0),
        TimelineError(page: 0, error: tException)
      ];

      bloc.add(const TimelineStarted());
      expectLater(bloc.stream, emitsInOrder(expected));
    },
  );
}
