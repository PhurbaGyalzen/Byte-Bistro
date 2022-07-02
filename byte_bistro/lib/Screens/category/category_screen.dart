import 'package:byte_bistro/Screens/category/add_category.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/colors.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Get.bottomSheet(
              AddCategory(),
              isDismissible: false,
              elevation: 20,
              backgroundColor: Colors.white,
            );
          },
          icon: Icon(Icons.add),
        ),
        Expanded(
          flex: 50,
          child: SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: GetBuilder<CategoryController>(
              builder: (controller) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 15, top: 5, right: 15, bottom: 5),
                      margin: EdgeInsets.all(10),
                      child: Text(controller.categoryList[index].name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                            letterSpacing: 0.1,
                          )),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(50)),
                    );
                  }),
                  itemCount: controller.categoryList.length),
            ),
          ),
        ),
      ],
    );
  }
}
