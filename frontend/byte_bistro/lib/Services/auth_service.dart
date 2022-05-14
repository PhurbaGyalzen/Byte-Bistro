import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';

class AuthService {
  static Future<LoginResponse?> login(String username, String password) async {
    const endpoint = PersistentHtpp.baseUrl + 'auth/signin';
    var response = await PersistentHtpp.client.post(Uri.parse(endpoint), body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return LoginResponse.fromJson(json);
    } else {
      return null;
    }
  }
}

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.message,
    required this.token,
  });

  String message;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
