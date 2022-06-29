import 'package:byte_bistro/Services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = [].obs;
  CartService cartService = Get.put(CartService());
  var foodQuantity = 1.obs;
  var foodPrice = 0.obs;
  var noOfItems = 1.obs;
  var noOfCartItems = 0.obs;

  @override
  void onInit() {
    // getSingleCart();
    super.onInit();
  }

  addFood() {
    noOfItems.value++;
  }

  removeFood() {
    if (noOfItems.value > 1) {
      noOfItems.value--;
    } else {
      Get.snackbar(
        "Item",
        "Must choose at least 1 food ",
        icon: Icon(Icons.no_meals, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        animationDuration: Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  getAllCart() async {
    var response = await cartService.getAllCart();
    cartList.value = response;
    return response;
  }

  updatePrice(int price) {
    foodPrice.value = price * foodQuantity.value;
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
