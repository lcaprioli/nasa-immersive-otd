import 'package:nasa_immersive_od/features/immersive/data/datasources/immersive_local_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/data/datasources/immersive_remote_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/shared/services/connection_check_service.dart';

class ImmersiveRepository {
  ImmersiveRepository({
    required ConnectionCheckService connectionCheck,
    required ImmersiveRemoteDatasource remoteDatasource,
    required ImmersiveLocalDatasource localDatasource,
  })  : _connectionCheck = connectionCheck,
        _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  final ConnectionCheckService _connectionCheck;
  final ImmersiveRemoteDatasource _remoteDatasource;
  final ImmersiveLocalDatasource _localDatasource;

  Future<Set<ImmersiveEntity>> get(DateTime start, DateTime end) async {
    if (await _connectionCheck.connected) {
      try {
        final result = await _remoteDatasource.getApod(start, end);
        if (result.isEmpty) {
          throw Exception('No data found');
        }
        await _localDatasource.write(result);
        return result;
      } catch (e) {
        throw Exception('An error occurred trying to get the remote data: $e');
      }
    } else {
      try {
        final result = await _localDatasource.get(start, end);
        if (result.isEmpty) {
          throw Exception('No data found');
        }
        return result;
      } catch (e) {
        throw Exception('An error occurred trying to get the cached data: $e');
      }
    }
  }
}
