import 'package:byte_bistro/Models/category.dart';
import 'package:byte_bistro/Services/category_service.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: controller.getAllCategory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Category> data = snapshot.data as List<Category>;
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                        itemBuilder: ((context, index) {
                          return ListTile(
                            title: Text(data[index].name),
                          );
                        }),
                        itemCount: data.length),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
