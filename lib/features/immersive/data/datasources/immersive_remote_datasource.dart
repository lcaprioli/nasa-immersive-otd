import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/shared/services/api_service/api_service.dart';
import 'package:nasa_immersive_od/shared/utils/date_utils.dart';

class ImmersiveRemoteDatasource {
  ImmersiveRemoteDatasource(
    ApiService apiService,
  ) : _apiService = apiService;

  final ApiService _apiService;

  Future<Set<ImmersiveDto>> getApod(DateTime start, DateTime end) async {
    try {
      final data = await _apiService.get(
        {
          'start_date': start.toApiFormat(),
          'end_date': end.toApiFormat(),
        },
      ) as List<dynamic>;
      final resultList = <ImmersiveDto>{};
      for (var json in data) {
        final dto = ImmersiveDto.fromJson(json);
        final imageBytes = await _apiService.downloadImageData(dto.url);
        /* final hdImageBytes = (dto.hdurl != null)
            ? await _apiService.downloadImageData(dto.hdurl!)
            : null; */
        resultList.add(dto.copyWithBytes(imageBytes, null));
        print(dto.date);
        await Future.delayed(const Duration(seconds: 1));
      }
      return resultList;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
