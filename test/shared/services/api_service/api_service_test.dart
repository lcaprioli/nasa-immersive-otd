import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:nasa_immersive_od/shared/services/api_service/api_service.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/fixture_reader.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  final Dio dio = Dio();

  late DioAdapterMock dioAdapterMock;
  late ApiService apiService;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    apiService = ApiService(dio);

    registerFallbackValue(RequestOptions());
  });

  test('get', () async {
    final httpResponse = ResponseBody.fromString(
      fixture('apod_item.json'),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(() => dioAdapterMock.fetch(any(), any(), any()))
        .thenAnswer((_) async => httpResponse);

    final response = await apiService.get({});
    final expected = jsonDecode(fixture('apod_item.json'));

    expect(response, equals(expected));
  });
}
