import 'package:byte_bistro/Services/cart_admin.dart';

import 'package:get/get.dart';

class CartAdminController extends GetxController {
  var cartList = [].obs;
  CartAdminService cartService = Get.put(CartAdminService());
  var foodQuantity = 1.obs;
  var foodPrice = 0.obs;

  @override
  void onInit() {
    // getSingleCart();
    super.onInit();

  }

  

  getAllCart() async {
    var response = await cartService.getAllCart();
    cartList.value = response;
    return response;
  }

  
}
