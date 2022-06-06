import 'package:byte_bistro/Services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body:SafeArea(child: SingleChildScrollView(
      //   child:Container(child:FutureBuilder(builder:  ,)),
      // ),),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            CategoryService service = CategoryService();
            var data = service.getAllCategory();
            print(data);
          },
          child: Text('Call Category')),
    );
  }
}
