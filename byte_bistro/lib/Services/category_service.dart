import 'package:byte_bistro/Services/http_service.dart';

import '../models/category.dart';

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

  // add new category
  Future addNewCategory(Map<String, String> data) async {
    String endpoint = PersistentHtpp.baseUrl + 'category';
    try {
      final response =
          await PersistentHtpp.client.post(Uri.parse(endpoint), body: data);
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return Future.error('Internal server error');
      }
    } catch (err) {
      return Future.error('Error fetching data $err');
    }
  }

  deleteCategory(String categoryId) async {
    String endpoint = PersistentHtpp.baseUrl + 'category/$categoryId';
    try {
      final response = await PersistentHtpp.client.delete(
        Uri.parse(endpoint),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        return 'success';
      }
    } catch (err) {
      return Future.error(' err');
    }
  }
}
