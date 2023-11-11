import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_immersive_od/features/immersive/data/datasources/immersive_local_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/shared/services/local_storage_service/local_storage_service.dart';

import '../../../../fixtures/fixture_reader.dart';

class LocalStorageServiceMock extends Mock implements LocalStorageService {}

void main() {
  late ImmersiveLocalDatasource dataSource;
  late LocalStorageService localStorageService;

  final startDate = DateTime(2017, 7, 8);
  final endDate = DateTime(2017, 7, 10);

  setUp(() {
    localStorageService = LocalStorageServiceMock();
    dataSource = ImmersiveLocalDatasource(localStorageService);
  });

  void setUpLocalStorageServiceSuccess() {
    when(() => localStorageService.get('2017-07-08'))
        .thenReturn(jsonDecode(fixture('apod_item_2017-07-08.json')));
    when(() => localStorageService.get('2017-07-09'))
        .thenReturn(jsonDecode(fixture('apod_item_2017-07-09.json')));
    when(() => localStorageService.get('2017-07-10'))
        .thenReturn(jsonDecode(fixture('apod_item_2017-07-10.json')));
  }

  void setUpLocalStorageServiceFailure() {
    when(() => localStorageService.get(any()))
        .thenAnswer((_) => throw Exception());
  }

  group('get', () {
    final list = [
      json.decode(fixture('apod_item_2017-07-08.json')),
      json.decode(fixture('apod_item_2017-07-09.json')),
      json.decode(fixture('apod_item_2017-07-10.json')),
    ];
    final tImmersiveDtos = list
        .map(
          (e) => ImmersiveDto.fromJson(e),
        )
        .toSet();

    test(
      'success',
      () async {
        setUpLocalStorageServiceSuccess();
        dataSource.get(startDate, endDate);

        verify(() => localStorageService.get(any()));
      },
    );

    test(
      'should return ImmersiveDto (success)',
      () async {
        setUpLocalStorageServiceSuccess();
        final result = dataSource.get(startDate, endDate);
        expect(result, equals(tImmersiveDtos));
      },
    );

    test(
      'should throw a Exception when fails',
      () async {
        setUpLocalStorageServiceFailure();
        final call = dataSource.get;
        expect(() => call(startDate, endDate),
            throwsA(const TypeMatcher<Exception>()));
      },
    );
  });
}
