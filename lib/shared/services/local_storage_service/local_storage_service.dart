import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<Map<String, dynamic>?> get(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString(key);
    if (data == null) return null;
    return jsonDecode(data);
  }

  Future<void> set(String key, dynamic value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, jsonEncode(value));
  }
}
