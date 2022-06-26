import 'dart:convert';
import 'dart:io';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/food.dart';
import 'package:dio/dio.dart' as dio;

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

  static Future signup(
      String username, String password, String email, String fullname) async {
    String endpoint = PersistentHtpp.baseUrl + 'auth/signup';
    var response = await PersistentHtpp.client.post(Uri.parse(endpoint), body: {
      'username': username,
      'password': password,
      'email': email,
      "fullname": fullname
    });
    if (response.statusCode == 201) {
      var json = jsonDecode(response.body);
      print(json);
      return "User Registered Successfully";
    } else {
      return null;
    }
  }

  static Future<LoginResponse?> googleAuth(
      String username, String googleId, String fullname, String email) async {
    String endpoint = PersistentHtpp.baseUrl + "auth/google";
    var response = await PersistentHtpp.client.post(Uri.parse(endpoint), body: {
      'username': username,
      'googleId': googleId,
      'fullname': fullname,
      'email': email
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
    // print("jsonResponse");
    // print(jsonResponse);

    // return foodFromJson(jsonResponse);
  }

  // update Profile
  static Future<String> updateProfile(File profileImage) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString("token");
    String endpoint = PersistentHtpp.baseUrl + 'auth/profile';
    var http = dio.Dio();
    var imageFileName = profileImage.path;
    var formData = dio.FormData.fromMap({
      'profile': await dio.MultipartFile.fromFile(profileImage.path,
          filename: imageFileName),
    });
    try {
      final response = await http.patch(
        endpoint,
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return Future.error('err');
      }
    } catch (err) {
      return Future.error(' err');
    }
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
