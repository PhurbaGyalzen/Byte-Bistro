// import 'package:byte_bistro/Models/food.dart';
import 'package:byte_bistro/Screens/admin/widgets/update_food.dart';
import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/food_controller.dart';

class ViewFood extends StatefulWidget {
  const ViewFood({Key? key}) : super(key: key);

  @override
  State<ViewFood> createState() => _ViewFoodState();
}

class _ViewFoodState extends State<ViewFood> {
  FoodController foodController = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: foodController.getAllFood(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Food> data = snapshot.data as List<Food>;
          return SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 355,
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 5,
                    right: 5,
                    bottom: 8,
                  ),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                        color: Color(0xFFB0CCE1).withOpacity(0.32),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          height: 1.3,
                          letterSpacing: 0.5,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                data[index].description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5,
                                  color: kTextLightColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  height: 120,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data[index].image)),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Text(
                            'Rs ${data[index].price.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              height: 1.3,
                              letterSpacing: 0.5,
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(
                            width: 220,
                          ),
                          GestureDetector(
                            onTap: () => showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: Text(
                                        'Are you sure you want to delete this item?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                        onPressed: () {
                                          foodController
                                              .deleteFood(data[index].id);
                                          setState(() {});
                                          Get.back();
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            child: Image(
                              image: AssetImage('assets/images/delete.png'),
                              width: 25,
                              height: 25,
                              color: Colors.red.withOpacity(0.5),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => showMaterialDialog(
                              data[index].id,
                              data[index].name,
                              data[index].price,
                              data[index].description,
                              data[index].image,
                            ),
                            //     foodController.updateFood(data[index].id, {
                            //   "name": data[index].name,
                            //   "price": data[index].price,
                            //   "description": data[index].description,
                            //   "image": data[index].image
                            // }
                            // ),
                            child: Image(
                              image: AssetImage('assets/images/edit.png'),
                              width: 25,
                              height: 25,
                              color: Colors.black.withOpacity(0.5),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
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
    );
  }

  void showMaterialDialog(
      String id, String name, int price, String description, String image) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Dialog(
              insetAnimationCurve: Curves.fastOutSlowIn,
              insetAnimationDuration: Duration(seconds: 2),
              elevation: 10,
              insetPadding: EdgeInsets.all(10),
              backgroundColor: Colors.white,
              child: UpdateFood(
                  id: id,
                  name: name,
                  price: price,
                  description: description,
                  image: image),
            ),
          );
        });
  }
}
