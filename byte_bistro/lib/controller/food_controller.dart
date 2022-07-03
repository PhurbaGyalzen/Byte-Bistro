import 'package:byte_bistro/Services/food_services.dart';
import 'package:get/get.dart';

import '../models/food.dart';

class FoodController extends GetxController {
  var foodList = [].obs;
  var foundFood = [].obs;
  bool isAvailable = false;

  @override
  void onInit() {
    getAllFood();
    super.onInit();
  }

  FoodService foodService = Get.put(FoodService());

  // get all food
  getAllFood() async {
    var data = await foodService.getAllFood();
    if (data != null) {
      foodList.value = data;
      return data;
    }
  }

  // get single food
  getSingleFood(String foodId) async {
    var response = foodService.getSingleFood(foodId);
    foodList.value = response as List;
    return response;
  }

  // add single food
  addFood(Map<String, dynamic> data) async {
    var response = foodService.addFood(data);
    return response;
  }

  // update single food
  updateFood(String foodId, Map<String, dynamic> data) async {
    var response = foodService.updateFood(foodId, data);
    return response;
  }

  // delete single food
  deleteFood(String foodId) async {
    var response = foodService.deleteFood(foodId);
    getAllFood();
    return response;
  }

  //set food Available
  setFoodAvailable(String foodId) async {
    var response = foodService.setFoodAvailable(foodId);
    getAllFood();
    // if (response == 'success') {
    //   var data = foodService.getAllFood();
    //   foodList.value = data as List;
    //   // foodList.refresh();
    // }
    return response;
  }

  //set food Unavailable
  setFoodUnavailable(String foodId) async {
    var response = foodService.setFoodUnavailable(foodId);
    // if (response == 'success') {
    //   var data = foodService.getAllFood();
    //   foodList.value = data as List;
    //   // foodList.refresh();
    // }
    getAllFood();
    return response;
  }

  //search and filter food
  searchFood(String search) async {
    var response = await FoodService.searchFood(search);
    print(response);
    foodList.value = response;
  }
}
