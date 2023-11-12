import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService(
    SharedPreferences sharedPreferences,
  ) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  Map<String, dynamic>? get(String key) {
    final data = _sharedPreferences.getString(key);
    if (data == null) return null;
    return jsonDecode(data);
  }

  Future<void> set(String key, dynamic value) async {
    await _sharedPreferences.setString(key, jsonEncode(value));
  }
}
