import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_immersive_od/features/immersive/data/datasource/immersive_remote_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/shared/services/api_service/api_service.dart';

import '../../../../fixtures/fixture_reader.dart';

class ApiServiceMock extends Mock implements ApiService {}

void main() {
  late ImmersiveRemoteDatasource dataSource;
  late ApiService apiService;
  setUp(() {
    apiService = ApiServiceMock();
    dataSource = ImmersiveRemoteDatasource(apiService);
  });

  void setUpApiServiceSuccess200() {
    when(() => apiService.get(any())).thenAnswer(
        (_) async => jsonDecode(fixture('apod_list.json')) as List<dynamic>);

    when(() => apiService.downloadImageData(any()))
        .thenAnswer((_) async => image('image_sample.jpg'));
  }

  void setUpApiServiceFailure404() {
    when(() => apiService.get(any()))
        .thenAnswer((_) async => throw Exception());
  }

  group('getApod', () {
    final list = json.decode(fixture('apod_list.json')) as List<dynamic>;
    final tImmersiveDtos = list.map(
      (e) => ImmersiveDto.fromJson(e),
    );

    test(
      'success',
      () async {
        setUpApiServiceSuccess200();
        dataSource.getApod(DateTime.now(), DateTime.now());

        verify(() => apiService.get(any()));
      },
    );

    test(
      'should return ImmersiveDto (success)',
      () async {
        setUpApiServiceSuccess200();
        final result = await dataSource.getApod(DateTime.now(), DateTime.now());
        expect(result, equals(tImmersiveDtos));
      },
    );

    test(
      'should throw a Exception when the response code is 404 or other',
      () async {
        setUpApiServiceFailure404();
        final call = dataSource.getApod;
        expect(() => call(DateTime.now(), DateTime.now()),
            throwsA(const TypeMatcher<Exception>()));
      },
    );
  });
}
