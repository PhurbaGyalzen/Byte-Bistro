import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';

import '../Models/food.dart';

class AuthService {
  static Future<LoginResponse?> login(String username, String password) async {
    String endpoint = PersistentHtpp.baseUrl + 'auth/signin';
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

  static Future<Food> fetchFoodDetails(String foodId) async {
    String endpoint = PersistentHtpp.baseUrl + 'food/$foodId';

    final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
    final jsonResponse = response.body;
    // also handle errors
    return foodFromJson(jsonResponse);
  }

  ///ansfjnsjfn
  static Future<void> fetchUSerDetails(String token) async {
    String endpoint = PersistentHtpp.baseUrl + 'auth/one_user';

    final response =
        await PersistentHtpp.client.get(Uri.parse(endpoint), headers: {
      'Authorization': 'Bearer $token',
    });

    final jsonResponse = response.body;
    print("jsonResponse");
    print(jsonResponse);

    // return foodFromJson(jsonResponse);
  }
}

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse(
      {required this.message, required this.token, required this.isAdmin});

  String message;
  String token;
  bool isAdmin;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      message: json["message"], token: json["token"], isAdmin: json["isAdmin"]);

  Map<String, dynamic> toJson() =>
      {"message": message, "token": token, "isAdmin": isAdmin.toString()};
}
