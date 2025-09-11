import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///缓存工具类
class SharedPreferencesUtil {
  late SharedPreferences prefs;

  factory SharedPreferencesUtil() => _sharedPreferencesUtil();

  static final SharedPreferencesUtil _instance = SharedPreferencesUtil._();

  static SharedPreferencesUtil _sharedPreferencesUtil() {
    return _instance;
  }

  SharedPreferencesUtil._();

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  //记录网络状态
  var onlineState = true;

  Future<bool> put(String key, dynamic object) {
    if (object is String) {
      return prefs.setString(key, object);
    } else if (object is int) {
      return prefs.setInt(key, object);
    } else if (object is bool) {
      return prefs.setBool(key, object);
    } else if (object is double) {
      return prefs.setDouble(key, object);
    } else if (object is List<String>) {
      return prefs.setStringList(key, object);
    } else if (object != null) {
      return prefs.setString(key, object.toString());
    } else {
      return prefs.setString(key, "");
    }
  }

  String getString(String key, {String defaultVal = ""}) {
    return prefs.getString(key) ?? defaultVal;
  }

  int getInt(String key, {int defaultVal = 0}) {
    return prefs.getInt(key) ?? defaultVal;
  }

  bool getBool(String key, {bool defaultVal = false}) {
    return prefs.getBool(key) ?? defaultVal;
  }

  double getDouble(String key, {double defaultVal = 0}) {
    return prefs.getDouble(key) ?? defaultVal;
  }

  List<String> getStringList(String key, List<String> defaultVal) {
    return prefs.getStringList(key) ?? defaultVal;
  }

  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return prefs.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  bool contains(String key) {
    return prefs.containsKey(key);
  }

  remove(String key) {
    return prefs.remove(key);
  }

  clear() {
    return prefs.clear();
  }
}
