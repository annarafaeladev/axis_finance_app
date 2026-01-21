import 'dart:convert';

import 'package:axis_finance_app/core/storage/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveString(StorageKey object, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(object.key, value);
  }
  

  Future<String?> getString(StorageKey object) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(object.key);
  }

  Future<void> saveMap(StorageKey object, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(object.key, jsonEncode(value));
  }

  Future<Map<String, dynamic>?> getMap(StorageKey object) async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(object.key);
    return json != null ? jsonDecode(json) : null;
  }

  Future<void> delete(StorageKey object) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(object.key);
  }

  Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
