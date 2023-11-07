import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_immersive_od/shared/services/local_storage_service/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  late LocalStorageService localStorageService;

  const kMockKey = 'localCache';
  final mockList = jsonDecode(fixture('apod_list.json')) as List<dynamic>;
  final mockItem = jsonDecode(fixture('apod_item.json'));

  SharedPreferences.setMockInitialValues({
    kMockKey: fixture('apod_list.json'),
  });

  setUp(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    localStorageService = LocalStorageService(sharedPreferences);
  });

  test('get', () {
    final data = localStorageService.get<List<dynamic>>(kMockKey);
    expect(data, mockList);
  });

  test('set', () async {
    final expectedCount = mockList.length + 1;
    await localStorageService.set(kMockKey, mockList..add(mockItem));
    final actualCount =
        localStorageService.get<List<dynamic>>(kMockKey)?.length;
    expect(expectedCount, actualCount);
  });
}
