import 'package:byte_bistro/Services/category_service.dart';
import 'package:get/get.dart';

import '../Models/category.dart';

class CategoryController extends GetxController {
  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  List<Category> categoryList = [];
  CategoryService service = Get.put(CategoryService());
  // controller to get all category
  void getAllCategory() async {
    var data = await service.getAllCategory();
    if (data != null) {
      categoryList = data;
      update();
    }
  }

  void addNewCategory(Map<String, String> data) async {
    var response = await service.addNewCategory(data);
    if (response == 'success') {
      var getData = await service.getAllCategory();
      categoryList = getData;
      update();
    }
  }
}
