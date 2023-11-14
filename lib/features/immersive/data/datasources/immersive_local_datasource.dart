import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/shared/services/local_storage_service/local_storage_service.dart';
import 'package:nasa_immersive_od/shared/utils/date_utils.dart';

class ImmersiveLocalDatasource {
  ImmersiveLocalDatasource(
    LocalStorageService localStorageService,
  ) : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  Future<Set<ImmersiveDto>> get(DateTime start, DateTime end) async {
    try {
      final resultList = <ImmersiveDto>{};
      final endDate = end.add(const Duration(days: 1));
      DateTime currentDate = start;
      while (currentDate.isBefore(endDate)) {
        final itemData =
            await _localStorageService.get(currentDate.toApiFormat());
        if (itemData != null) {
          resultList.add(ImmersiveDto.fromJson(itemData));
        }

        currentDate = currentDate.add(const Duration(days: 1));
      }
      return resultList;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> write(Set<ImmersiveDto> items) async {
    try {
      for (final immersiveDto in items) {
        await _localStorageService.set(
          immersiveDto.date.toApiFormat(),
          immersiveDto.toJson(),
        );
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
