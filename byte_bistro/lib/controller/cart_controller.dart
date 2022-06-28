import 'package:byte_bistro/Services/cart_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartList = [].obs;
  CartService cartService = Get.put(CartService());
  var foodQuantity = 1.obs;
  var foodPrice = 0.obs;
  var noOfItems = 1.obs;

  @override
  void onInit() {
    // getSingleCart();
    super.onInit();
  }

  addFood() {
    noOfItems.value++;
    update();
  }

  removeFood() {
    if (noOfItems.value > 1) {
      noOfItems.value--;
    } else {}
    update();
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
