import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenService {
  static Future getTokenData() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString("token");
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    return payload;
  }
}
