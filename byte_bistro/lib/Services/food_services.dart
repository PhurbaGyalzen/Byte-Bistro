import 'package:byte_bistro/Services/http_service.dart';
import '../models/food.dart';

class FoodService {
  // get all food
  getAllFood() async {
    String endpoint = PersistentHtpp.baseUrl + 'food';
    final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
    final jsonResponse = response.body;
    if (response.statusCode == 200) {
      return foodFromJson(jsonResponse);
    } else {
      return null;
    }
  }

  // get single food
  getSingleFood(String foodId) async {
    String endpoint = PersistentHtpp.baseUrl + 'food/$foodId';

    final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
    final jsonResponse = response.body;
    if (response.statusCode == 200) {
      return foodFromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
