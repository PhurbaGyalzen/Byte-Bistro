import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    List<dynamic> cartList = [];
    return SizedBox(
      height: 280.0,
      child: FutureBuilder(
        future: foodController.getAllFood(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Food> data = snapshot.data as List<Food>;
            return SizedBox(
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 300.0,
                      autoPlay: true,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: 290,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 0,
                          right: 20,
                          bottom: 8,
                        ),
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                              color: Color(0xFFB0CCE1).withOpacity(0.32),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: NetworkImage(data[index].image),
                                height: 160,
                                width: MediaQuery.of(context).size.width - 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              data[index].name,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data[index].price.toString(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var cartData = {
                                      "index": index,
                                      "name": data[index].name,
                                      "price": data[index].price,
                                      "description": data[index].description,
                                      "image": data[index].image,
                                    };
                                    cartList.add(cartData);
                                    print(cartData);
                                    Get.toNamed('/addToCart',
                                        arguments: cartList);
                                  },
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/shoppingCart.png'),
                                      height: 20,
                                      width: 20),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }));
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
