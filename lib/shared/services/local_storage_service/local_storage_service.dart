import 'dart:convert';
import 'package:nasa_immersive_od/features/immersive/domain/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;
  Map<String, dynamic>? get(String key) {
    try {
      final data = _sharedPreferences.getString(key);
      if (data == null) return null;
      return jsonDecode(data);
    } catch (e) {
      throw LocalStorageReadException();
    }
  }

  Future<void> set(String key, dynamic value) async {
    try {
      await _sharedPreferences.setString(key, jsonEncode(value));
    } catch (e) {
      throw LocalStorageWriteException();
    }
  }
}
