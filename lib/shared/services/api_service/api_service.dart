import 'dart:async';

import 'package:dio/dio.dart';
import 'package:nasa_immersive_od/features/immersive/domain/exceptions/exceptions.dart';
import 'package:nasa_immersive_od/shared/services/api_service/api_service_consts.dart';

class ApiService {
  ApiService(
    Dio dio,
  ) : _dio = dio;

  final Dio _dio;

  Future<dynamic> get(Map<String, String> params) async {
    try {
      final response = await _dio.get(
        ApiServiceConsts.kUrl,
        queryParameters: Map.from(ApiServiceConsts.kApiKeyParam)
          ..addAll(params),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<int>> downloadImageData(String url) async {
    try {
      final response = await _dio.getUri(
        Uri.parse(url),
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ImageDownloadException();
      }
    } catch (e) {
      throw ImageDownloadException();
    }
  }
}
