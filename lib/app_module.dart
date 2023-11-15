import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_immersive_od/features/immersive/data/datasources/immersive_local_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/data/datasources/immersive_remote_datasource.dart';
import 'package:nasa_immersive_od/features/immersive/data/repositories/immersive_repository.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/detail/detail_page.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_page.dart';
import 'package:nasa_immersive_od/shared/services/api_service/api_service.dart';
import 'package:nasa_immersive_od/shared/services/connection_check_service.dart';
import 'package:nasa_immersive_od/shared/services/local_storage_service/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  AppModule(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind((i) => ConnectionCheckService()),
        Bind(
          (i) => LocalStorageService(sharedPreferences: sharedPreferences),
        ),
        Bind((i) => ApiService(Modular.get<Dio>())),
        Bind((i) =>
            ImmersiveLocalDatasource(Modular.get<LocalStorageService>())),
        Bind((i) => ImmersiveRemoteDatasource(Modular.get<ApiService>())),
        Bind((i) => ImmersiveRepository(
            connectionCheck: Modular.get<ConnectionCheckService>(),
            localDatasource: Modular.get<ImmersiveLocalDatasource>(),
            remoteDatasource: Modular.get<ImmersiveRemoteDatasource>())),
        Bind((i) =>
            TimelineBloc(repository: Modular.get<ImmersiveRepository>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => TimelinePage(
            bloc: Modular.get<TimelineBloc>(),
          ),
        ),
        ChildRoute(
          '/detail',
          child: (context, args) => DetailPage(
            immersive: args.data,
          ),
        ),
      ];
}
