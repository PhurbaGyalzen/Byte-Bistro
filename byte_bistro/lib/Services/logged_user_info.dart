import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/loged_user_info.dart';

class LoggedUserInfoService {
  // update profile
  static Future<String> updateUserInfoService(
    Map<String, dynamic> data,
  ) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString("token");
    String endpoint = PersistentHtpp.baseUrl + 'auth/profile_update';

    try {
      final response = await PersistentHtpp.client
          .put(Uri.parse(endpoint), body: jsonEncode(data), headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json; charset=UTF-8",
      });
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return Future.error('err');
      }
    } catch (err) {
      return Future.error(' err');
    }
  }

  //
  static Future<LoggedUserInfo> getUserInfoSevice() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString("token");
    // var prefs = SharedPreferences();
    String endpoint = PersistentHtpp.baseUrl + 'auth/one_user';
    try {
      final response =
          await PersistentHtpp.client.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
      });

      final jsonResponse = response.body;
      if (response.statusCode == 200) {
        return loggedUserInfoFromJson(jsonResponse);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }
}
