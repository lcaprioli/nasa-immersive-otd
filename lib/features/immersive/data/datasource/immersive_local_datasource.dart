import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/shared/services/local_storage_service/local_storage_service.dart';

class ImmersiveLocalDatasource {
  ImmersiveLocalDatasource(
    LocalStorageService localStorageService,
  ) : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  static const kKey = 'apod-database';
  Set<ImmersiveDto> get(DateTime start, DateTime end) {
    try {
      final data =
          _localStorageService.get<List<Map<String, dynamic>>>(kKey) ?? [];

      final filteredData = data.where((json) {
        if (json['date'] == null) return false;
        final itemDate = DateTime.parse(json['date']);
        return itemDate.isAfter(start) && itemDate.isBefore(end);
      });
      return filteredData.map((json) => ImmersiveDto.fromJson(json)).toSet();
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> cache(Set<ImmersiveDto> items) async {
    try {
      await _localStorageService.set(kKey, items.map((dto) => dto.toJson()));
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
