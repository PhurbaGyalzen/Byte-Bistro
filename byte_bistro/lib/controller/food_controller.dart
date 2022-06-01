import 'package:byte_bistro/Services/food_services.dart';
import 'package:get/get.dart';


class FoodController extends GetxController {
  var foodList = [].obs;
  FoodService foodService = Get.put(FoodService());

  @override
  void onInit() {
    getAllFood();
    super.onInit();
  }

  // get all food
  getAllFood() async {
    var response = await foodService.getAllFood();
    foodList.value = response;
    return response;
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
    return response;
  }

  //set food Available
  setFoodAvailable(String foodId) async {
    var response = foodService.setFoodAvailable(foodId);
    return response;
  }

  //set food Unavailable
  setFoodUnavailable(String foodId) async {
    var response = foodService.setFoodUnavailable(foodId);
    return response;
  }

}
