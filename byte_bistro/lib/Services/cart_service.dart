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
}
