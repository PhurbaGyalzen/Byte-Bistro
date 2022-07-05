import 'package:byte_bistro/controller/category_controller.dart';
import 'package:byte_bistro/models/category.dart';
import 'package:flutter/material.dart';
import 'package:byte_bistro/Screens/Category_momo.dart';
import 'package:get/get.dart';

class FoodTab extends StatefulWidget {
  FoodTab({Key? key}) : super(key: key);

  @override
  State<FoodTab> createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  var catName;
  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headline1),
          SizedBox(
            height: 70,
            child: FutureBuilder(
              future: categoryController.getAllCategory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Category> data = snapshot.data as List<Category>;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryController.categoryList.length,
                    itemBuilder: ((context, index) => GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                catName =
                                    categoryController.categoryList[index].name;
                              },
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MOMO(
                                  catName: catName,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            width: 115,
                            margin: EdgeInsets.only(
                              right: 16,
                              bottom: 5,
                              top: 10,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                  color: Color(0xFFB0CCE1).withOpacity(0.32),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              categoryController.categoryList[index].name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        )),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
