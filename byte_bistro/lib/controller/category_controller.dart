import 'package:byte_bistro/Services/category_service.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../models/category.dart';

class CategoryController extends GetxController {
  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  List<Category> categoryList = [];
  List<MultiSelectItem> dropDownData = [];
  var selectedCategoryValue = ''.obs;
  CategoryService service = Get.put(CategoryService());
  // controller to get all category
  getAllCategory() async {
    categoryList.clear();
    dropDownData.clear();
    var data = await service.getAllCategory();
    categoryList = data;
    dropDownData = data
        .map((e) {
          return MultiSelectItem(e, e.name);
        })
        .cast<MultiSelectItem>()
        .toList();

    update();

    return data;
  }

  addNewCategory(Map<String, String> data) async {
    var response = await service.addNewCategory(data);
    if (response == 'success') {
      var getData = await service.getAllCategory();
      categoryList = getData;
      update();
      return response;
    }
  }
}
