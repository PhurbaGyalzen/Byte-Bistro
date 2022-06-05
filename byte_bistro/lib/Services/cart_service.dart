import 'package:byte_bistro/models/cart.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';

class CartService {
  // Future<List<Cart>> getAllCart() async {
  //   String endpoint = PersistentHtpp.baseUrl + 'cart';
  //   try {
  //     final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
  //     final jsonResponse = response.body;
  //     if (response.statusCode == 200) {
  //       return cartFromJson(jsonResponse);
  //     } else {
  //       return Future.error('Internal Server Error');
  //     }
  //   } catch (err) {
  //     return Future.error(' Error fetching data $err');
  //   }
  // }

  Future<List<Cart>> getAllCart() async {
    print("kra2 inside getAllCart");
    String endpoint = PersistentHtpp.baseUrl + 'cart';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final jsonResponse = response.body;
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return List<Cart>.from(
            json.decode(jsonResponse).map((x) => Cart.fromJson(x)));
      } else {
        print("kra else");
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      print("kra catch");
      print(err);
      return Future.error(' Error fetching data $err');
    }
  }

  Future getSingleCart(String cartId) async {
    String endpoint = PersistentHtpp.baseUrl + 'cart/$cartId';

    final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
    final jsonResponse = response.body;
    if (response.statusCode == 200) {
      return cartFromJson(jsonResponse);
    } else {
      return null;
    }
  }

  Future addCart(Map<String, dynamic> data) async {
    String endpoint = PersistentHtpp.baseUrl + 'cart';
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

  Future<String> updateCart(
    String cartId,
    Map<String, dynamic> data,
  ) async {
    var endpoint = PersistentHtpp.baseUrl + 'cart/$cartId';

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

  deleteCart(String cartId) async {
    String endpoint = PersistentHtpp.baseUrl + 'cart/$cartId';
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
