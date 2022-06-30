import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/change_password.dart';

class ChangePasswordService {
  // update profile
  static Future<String> changePasswordService(
    Map<String, dynamic> data,
  ) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString("token");
    String endpoint = PersistentHtpp.baseUrl + 'auth/changepassword/';

    try {
      final response = await PersistentHtpp.client
          .put(Uri.parse(endpoint), body: jsonEncode(data), headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["message"];
      } else {
        return jsonDecode(response.body)["message"];
      }
    } catch (err) {
      return Future.error(' err');
    }
  }

  static Future<Map<String, dynamic>> setNewPassword(String password) async {
    http.Response response = await PersistentHtpp.post('auth/setNewPassword',
        body: jsonEncode({'newPassword': password}));
    return jsonDecode(response.body);
  }
}
