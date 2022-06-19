import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const AndroidOptions androidOpts =
    AndroidOptions(encryptedSharedPreferences: true);
const FlutterSecureStorage storage = FlutterSecureStorage();

class Storage {
  static Future<void> set(String key, String value) async {
    return await storage.write(key: key, value: value, aOptions: androidOpts);
  }

  static Future<String?> get(String key) async {
    return await storage.read(key: key, aOptions: androidOpts);
  }

  static Future<void> remove(String key) async {
    return await storage.delete(key: key, aOptions: androidOpts);
  }

  static Future<void> setObject(String key, dynamic value) async {
    String obj = jsonEncode(value);
    return await set(key, obj);
  }

  static Future<dynamic> getObject(String key) async {
    // returns either List<dynamic> or Map<dynamic, dynamic>
    String? value = await get(key);
    if (value == null) {
      return value;
    }
    return jsonDecode(value);
  }

  
}
