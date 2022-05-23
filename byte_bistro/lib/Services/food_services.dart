import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';

import '../Screens/home/models/food_model.dart';

class FoodService {
  // get all food
  Future<List<Food>> getAllFood() async {
    String endpoint = PersistentHtpp.baseUrl + 'food';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final jsonResponse = response.body;
      if (response.statusCode == 200) {
        return foodFromJson(jsonResponse);
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
    try {
      final response = await PersistentHtpp.client.post(
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
}
