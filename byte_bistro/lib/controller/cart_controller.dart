import 'package:byte_bistro/Services/cart_service.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:byte_bistro/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = [].obs;
  var adminCartList = [].obs;
  CartService cartService = Get.put(CartService());
  var foodQuantity = 1.obs;
  var foodPrice = 0.obs;
  var noOfItems = 1.obs;
  var noOfCartItems = 0.obs;
  var tableNumber = 0.obs;

  @override
  void onInit() {
    getPendingOrders();
    super.onInit();
  }

// add food count
  addFoodCount(int index) {
    cartList[index]['foodCount'] += noOfItems.value;
    cartList.refresh();
  }

// remove food count
  removeFoodCount(int index) {
    if (cartList[index]['foodCount'] > 1) {
      cartList[index]['foodCount'] -= noOfItems.value;
      cartList.refresh();
    } else {
      Get.snackbar(
        "Item",
        "Must choose at least 1 food ",
        icon: Icon(Icons.no_meals, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        animationDuration: Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // controller to remove food from cartList
  void removeFoodFromList(int index) {
    cartList.removeAt(index);
    cartList.refresh();
  }

  // controller to remove all item from cartList
  void removeAllItemFromList() {
    cartList.clear();
    cartList.refresh();
  }

// controller to add food in cart
  addFoodInCart(Map<String, dynamic> food) {
    if (cartList.isEmpty) {
      cartList.add(food);
      return true;
    } else {
      var customList = cartList.where((item) {
        return item['index'] == food['index'];
      });
      // if list doesn't contain that food we will add
      if (customList.isEmpty) {
        cartList.add(food);
        return true;
      } else {
        return false;
      }
    }
  }

  getAllCart() async {
    var response = await cartService.getAllCart();
    cartList.value = response;
    return response;
  }

  Future<List<Cart>> getPendingOrders() async {
    List<Cart> response = await cartService.getAllCart();
    List<Cart> orders =
        response.where((e) => e.status < CartStatus.Completed.index).toList();
    adminCartList.value = orders;
    return orders;
  }

// to update food price
  updatePrice(int index) {
    var price = cartList[index]['price'];
    cartList[index]['price'] =
        cartList[index]['price'] * cartList[index]['foodCount'];
    foodPrice.value = cartList[index]['price'];
    cartList[index]['price'] = price;
    print(foodPrice.value);
    cartList.refresh();
  }

  updateDuration(String cartId, int newDurationInMins) async {
    await cartService.updateCart(cartId, {'duration': newDurationInMins});
  }

  getSingleCart(String cartId) async {
    var response = await cartService.getSingleCart(cartId);
    cartList.value = response;
    return response;
  }

  Future<Cart> getCurrUserCart() async {
    var curr = await cartService.currUserCart();
    print(curr);
    return curr;
  }

  Future<bool> increaseDuration(String id, int duration) async {
    await cartService.changeDuration(id, duration, type: 'inc');
    return true;
  }

  Future<bool> decreaseDuration(String id, int duration) async {
    await cartService.changeDuration(id, duration, type: 'dec');
    return true;
  }

  Future<bool> changeDuration(String id, int duration) async {
    await cartService.changeDuration(id, duration);
    return true;
  }

  Future addCart(Map<String, dynamic> data) async {
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
