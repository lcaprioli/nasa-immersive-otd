import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_immersive_od/features/immersive/data/datasources/immersive_local_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/data/datasources/immersive_remote_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/features/immersive/data/repositories/immersive_repository.dart';
import 'package:nasa_immersive_od/shared/services/connection_check_service.dart';

import '../../../fixtures/fixture_reader.dart';

class MockRemoteDatasource extends Mock implements ImmersiveRemoteDatasource {}

class MockLocalDatasource extends Mock implements ImmersiveLocalDatasource {}

class MockConnectionCheckService extends Mock
    implements ConnectionCheckService {}

void main() {
  late ImmersiveRepository repository;
  late MockRemoteDatasource mockRemoteDatasource;
  late MockLocalDatasource mockLocalDatasource;
  late ConnectionCheckService mockConnectionCheckService;

  final startDate = DateTime(2017, 7, 8);
  final endDate = DateTime(2017, 7, 10);

  mockRemoteDatasource = MockRemoteDatasource();
  mockLocalDatasource = MockLocalDatasource();
  mockConnectionCheckService = MockConnectionCheckService();
  repository = ImmersiveRepository(
    remoteDatasource: mockRemoteDatasource,
    localDatasource: mockLocalDatasource,
    connectionCheck: mockConnectionCheckService,
  );
  setUp(() {});
  final tImmersiveList = {
    ImmersiveDto.fromJson(json.decode(fixture('apod_item_2017-07-08.json'))),
    ImmersiveDto.fromJson(json.decode(fixture('apod_item_2017-07-09.json'))),
    ImmersiveDto.fromJson(json.decode(fixture('apod_item_2017-07-10.json'))),
  };

  group('online', () {
    setUp(() {
      when(() => mockConnectionCheckService.connected)
          .thenAnswer((_) async => true);
    });
    test(
      'should return local data when the call to remote data source is successful',
      () async {
        when(() => mockRemoteDatasource.getApod(startDate, endDate))
            .thenAnswer((_) async => tImmersiveList);
        when(() => mockLocalDatasource.write(tImmersiveList))
            .thenAnswer((_) async {});

        final result = await repository.get(startDate, endDate);

        expect(result, tImmersiveList);
      },
    );
    test(
      'should return error when the call to remote data source has failed',
      () async {
        when(() => mockRemoteDatasource.getApod(startDate, endDate))
            .thenAnswer((_) async => throw Exception());

        final call = repository.get;
        expect(() => call(DateTime.now(), DateTime.now()),
            throwsA(const TypeMatcher<Exception>()));
      },
    );
    test(
      'should return error when no remote data is returned',
      () async {
        when(() => mockRemoteDatasource.getApod(startDate, endDate))
            .thenAnswer((_) async => Set.unmodifiable({}));

        final call = repository.get;
        expect(() => call(DateTime.now(), DateTime.now()),
            throwsA(const TypeMatcher<Exception>()));
      },
    );
  });
  group('offline', () {
    setUp(() {
      when(() => mockConnectionCheckService.connected)
          .thenAnswer((_) async => false);
    });
    test(
      'should return local data when the a connection is not avaliable',
      () async {
        when(() => mockLocalDatasource.get(startDate, endDate))
            .thenReturn(tImmersiveList);

        final result = await repository.get(startDate, endDate);

        expect(result, tImmersiveList);
      },
    );

    test(
      'should return error when the call to local data source has failed',
      () async {
        when(() => mockLocalDatasource.get(startDate, endDate))
            .thenAnswer((_) => throw Exception());

        final call = repository.get;
        expect(() => call(DateTime.now(), DateTime.now()),
            throwsA(const TypeMatcher<Exception>()));
      },
    );

    test(
      'should return error when no local data is returned',
      () async {
        when(() => mockLocalDatasource.get(startDate, endDate))
            .thenAnswer((_) => Set.unmodifiable({}));

        final call = repository.get;
        expect(() => call(DateTime.now(), DateTime.now()),
            throwsA(const TypeMatcher<Exception>()));
      },
    );
  });
}
