
import 'package:byte_bistro/Services/http_service.dart';

import '../models/cart_admin.dart';

class CartAdminService {
  Future<List<CartAdmin>> getAllCart() async {
    print("kra2 inside getAllCart");
    String endpoint = PersistentHtpp.baseUrl + 'cart';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final jsonResponse = response.body;
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return cartAdminFromJson(jsonResponse);
      } else {
        print("kra else");
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      print("kra catch");
      print(err);
      return Future.error(' Error fetching data $err');
    }
  }
}
