// import 'package:byte_bistro/Models/category.dart';
// import 'package:byte_bistro/Screens/category/add_category.dart';
// import 'package:byte_bistro/controller/category_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     CategoryController controller = Get.put(CategoryController());
//     return FutureBuilder(
//         future: controller.getAllCategory(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final List<Category> data = snapshot.data as List<Category>;
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Get.bottomSheet(
//                       AddCategory(),
//                       isDismissible: false,
//                       elevation: 20,
//                       backgroundColor: Colors.white,
//                     );
//                   },
//                   icon: Icon(Icons.add),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     height: 55,
//                     width: MediaQuery.of(context).size.width,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: ((context, index) {
//                           return Container(
//                             padding: EdgeInsets.only(
//                                 left: 15, top: 5, right: 15, bottom: 10),
//                             margin: EdgeInsets.all(10),
//                             child: Text(data[index].name,
//                                 style: Theme.of(context).textTheme.headline2),
//                             decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor,
//                                 borderRadius: BorderRadius.circular(50)),
//                           );
//                         }),
//                         itemCount: data.length),
//                   ),
//                 ),
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         });
//   }
// }

import 'package:byte_bistro/Models/category.dart';
import 'package:byte_bistro/Screens/category/add_category.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    var data = controller.categoryList;
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
          child: SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: GetBuilder<CategoryController>(
              builder: (controller) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 15, top: 5, right: 15, bottom: 10),
                      margin: EdgeInsets.all(10),
                      child: Text(controller.categoryList[index].name,
                          style: Theme.of(context).textTheme.headline2),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
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
