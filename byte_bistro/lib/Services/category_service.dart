import 'package:byte_bistro/Services/http_service.dart';

import '../Models/category.dart';

class CategoryService {
  // get all category
  Future<List<Category>> getAllCategory() async {
    String endpoint = PersistentHtpp.baseUrl + 'category';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final stringData = response.body;
      if (response.statusCode == 200) {
        var data = categoryFromJson(stringData);
        return data;
      } else {
        return Future.error('Internal Server Eror');
      }
    } catch (err) {
      return Future.error('Error fetching data $err');
    }
  }
}
