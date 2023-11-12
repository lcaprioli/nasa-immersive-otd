import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_immersive_od/shared/services/local_storage_service/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  late LocalStorageService localStorageService;

  const kMockKey = '2017-07-08';
  final mockItem = jsonDecode(fixture('apod_item.json'));

  SharedPreferences.setMockInitialValues({
    kMockKey: fixture('apod_item.json'),
  });

  setUp(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    localStorageService = LocalStorageService(sharedPreferences);
  });

  test('get', () {
    final data = localStorageService.get(kMockKey);
    expect(data, mockItem);
  });

  test('set', () async {
    SharedPreferences.setMockInitialValues({});
    await localStorageService.set(kMockKey, mockItem);
    final data = localStorageService.get(kMockKey);
    expect(data, mockItem);
  });
}
