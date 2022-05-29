import 'package:byte_bistro/Screens/add_to_cart/add_to_cart.dart';
import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabItem extends StatefulWidget {
  const TabItem({Key? key}) : super(key: key);

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  // final foodData = getFoodData();
  FoodController foodController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290.0,
      child: FutureBuilder(
        future: foodController.getAllFood(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Food> data = snapshot.data as List<Food>;
            return SizedBox(
              height: 600,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: ((context, index) => Container(
                      width: 170,
                      margin: EdgeInsets.only(
                        top: 60,
                        left: 0,
                        right: 18,
                        bottom: 8,
                      ),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                            color: Color(0xFFB0CCE1).withOpacity(0.32),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              top: -59,
                              left: 20,
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    border: Border.all(
                                        color: Colors.white30, width: 3)),
                              )),
                          Positioned(
                            top: -80,
                            left: 0,
                            child: Image(
                              image: NetworkImage(data[index].image),
                              height: 150,
                              width: 150,
                            ),
                          ),
                          Positioned(
                            top: 90,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                    letterSpacing: 0.5,
                                    color: kTextColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  data[index].description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5,
                                    color: kTextLightColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Row(
                              children: [
                                Text(data[index].price.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w200)),
                                SizedBox(width: 50),
                                GestureDetector(
                                  onTap: () => Get.to(AddToCart()),
                                  child: Image(
                                      image:
                                          AssetImage('assets/images/like.png'),
                                      height: 20,
                                      width: 20),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
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
      ),
    );
  }
}
