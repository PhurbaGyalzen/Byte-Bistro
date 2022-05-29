import 'dart:convert';

import 'package:byte_bistro/Services/cart_service.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = [].obs;
  CartService cartService = Get.put(CartService());
  var foodQuantity = 0.obs;

  @override
  void onInit() {
    // getSingleCart();
    super.onInit();
  }

  addQuantity() {
    foodQuantity.value++;
    update();
  }

  minusQuantity() {
    if (foodQuantity.value <= 0) {
      foodQuantity.value = 0;
    } else {
      foodQuantity.value--;
    }
    update();
  }

  getSingleCart(String cartId) async {
    var response = await cartService.getSingleCart(cartId);
    cartList.value = response;
    return response;
  }

  addCart(Map<String, dynamic> data) async {
    var response = await cartService.addCart(data);
    return response;
  }

  updateCart(String cartId, Map<String, dynamic> data) async {
    var response = await cartService.updateCart(cartId, data);
    return response;
  }

  deleteCart(String cartId) async {
    var response = await cartService.deleteCart(cartId);
    return response;
  }
}
