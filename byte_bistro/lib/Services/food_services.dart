import 'package:byte_bistro/Services/http_service.dart';

import '../Screens/home/models/food_model.dart';

class FoodService {
  // get all food
  static Future<List<Food>> getAllFood() async {
    String endpoint = PersistentHtpp.baseUrl + 'food';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final jsonResponse = response.body;
      if (response.statusCode == 200) {
        return foodFromJson(jsonResponse);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data');
    }
  }

  // get single food
  Future getSingleFood(String foodId) async {
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
