import 'package:byte_bistro/Services/food_services.dart';
import 'package:get/get.dart';

import '../Screens/home/models/food_model.dart';

class FoodController extends GetxController {
  var foodList = <Food>[].obs;
  FoodService foodService = Get.put(FoodService());

  // get all food
  getAllFood() {
    var response = foodService.getAllFood();
    return response;
  }

  // get single food
  getSingleFood(String foodId) {
    var response = foodService.getSingleFood(foodId);
    return response;
  }

  // add single food
  addFood(Map<String, dynamic> data) async {
    var response = foodService.addFood(data);
    return response;
  }

  // delete single food
  deleteFood(String foodId) {
    var response = foodService.deleteFood(foodId);
    return response;
  }
}
