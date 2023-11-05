import 'dart:async';

import 'package:dio/dio.dart';
import 'package:nasa_immersive_od/shared/services/api_service/api_service_consts.dart';

class ApiService {
  ApiService(
    Dio dio,
  ) : _dio = dio..options.baseUrl = ApiServiceConsts.kBaseUrl;

  final Dio _dio;

  Future<Map<String, dynamic>> get(Map<String, String> params) async {
    try {
      final response = await _dio.get(
        ApiServiceConsts.kPath,
        queryParameters: ApiServiceConsts.kApiKeyParam..addAll(params),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
