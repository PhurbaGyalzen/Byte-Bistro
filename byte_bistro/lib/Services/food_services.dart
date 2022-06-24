import 'dart:convert';
import 'dart:io';
import 'package:byte_bistro/Services/http_service.dart';

import '../Screens/home/models/food_model.dart';
import 'package:dio/dio.dart' as dio;

class FoodService {
  // get all food
  Future<List<Food>> getAllFood() async {
    String endpoint = PersistentHtpp.baseUrl + 'food';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final stringData = response.body;
      if (response.statusCode == 200) {
        return foodFromJson(stringData);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }

  // get single food
  Future getSingleFood(String foodId) async {
    String endpoint = PersistentHtpp.baseUrl + 'food/$foodId';

    final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
    final jsonResponse = response.body;
    if (response.statusCode == 200) {
      return foodFromJson(jsonResponse);
    } else {
      return null;
    }
  }

  // add food
  Future<String> addFood(Map<String, dynamic> data) async {
    String endpoint = PersistentHtpp.baseUrl + 'food';
    var http = dio.Dio();
    var imageFileName = data['image'].path;
    var formData = dio.FormData.fromMap({
      'name': data['name'],
      'price': data['price'],
      'image': await dio.MultipartFile.fromFile(data['image'].path,
          filename: imageFileName),
      'description': data['description'],
      'categories': data['categories'],
    });
    try {
      final response = await http.post(
        endpoint,
        data: formData,
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

  // update food
  Future<String> updateFood(
    String foodId,
    Map<String, dynamic> data,
  ) async {
    var endpoint = PersistentHtpp.baseUrl + 'food/$foodId';

    try {
      var response = await PersistentHtpp.client.patch(
        Uri.parse(endpoint),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
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

  // delete food
  deleteFood(String foodId) async {
    String endpoint = PersistentHtpp.baseUrl + 'food/$foodId';
    try {
      final response = await PersistentHtpp.client.delete(
        Uri.parse(endpoint),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
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

  // set food available
  setFoodAvailable(String foodId) async {
    String endpoint = PersistentHtpp.baseUrl + 'food/$foodId/setAvailable';
    try {
      final response = await PersistentHtpp.client.patch(
        Uri.parse(endpoint),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
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

  // set food unavailable
  setFoodUnavailable(String foodId) async {
    String endpoint = PersistentHtpp.baseUrl + 'food/$foodId/setUnAvailable';
    try {
      final response = await PersistentHtpp.client.patch(
        Uri.parse(endpoint),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
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

  //search and filter food
  static Future<List<Food>> searchFood(String search) async {
    if (search == '') {
      return FoodService().getAllFood();
    } else {
      String endpoint = PersistentHtpp.baseUrl + 'food/search/$search';
      try {
        final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
        final stringData = response.body;
        if (response.statusCode == 200) {
          return foodFromJson(stringData);
        } else {
          return foodFromJson('[]');
        }
      } catch (err) {
        return Future.error(' Error fetching data $err');
      }
    }
  }
}
