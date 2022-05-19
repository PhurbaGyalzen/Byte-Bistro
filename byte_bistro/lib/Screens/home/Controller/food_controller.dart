// Get all food data
import 'package:byte_bistro/Screens/home/models/food_model.dart';

getFoodData() {
  var foodData = {
    "name": "Chicken Biryani",
    "price": 150,
    "description": "National food of Nepal",
    "image": "image",
    "isAvailable": true,
    "avgRating": 5,
    "avgPrepTime": 30,
  };
  return Food.fromJson(foodData);
}
