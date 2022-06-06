import 'package:byte_bistro/Services/category_service.dart';
import 'package:get/get.dart';

import '../Models/category.dart';

class CategoryController extends GetxController {
  CategoryService service = Get.put(CategoryService());
  // controller to get all category
  Future<List<Category>> getAllCategory() {
    var data = service.getAllCategory();
    return data;
  }
}
