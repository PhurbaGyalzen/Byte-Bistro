import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:byte_bistro/controller/favourite_controller.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/favourite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TabItemDetail extends StatefulWidget {
  const TabItemDetail({Key? key}) : super(key: key);

  @override
  State<TabItemDetail> createState() => _TabItemDetailState();
}

class _TabItemDetailState extends State<TabItemDetail> {
  FoodController foodController = Get.find();
  LoggedUserInfoController loggedUserInfoController = Get.find();
  FavouriteController favouriteController = Get.find();
  var loggedUserInfo;
  List favouriteList = [];

  @override
  void initState() {
    super.initState();
    getFavourite();
  }

  Future getFavourite() async {
    loggedUserInfo = await loggedUserInfoController.getLoggedUserInfo();
    List<Favourite> response = await favouriteController
        .getUserFavourites(loggedUserInfo.id.toString());
    setState(() {
      favouriteList = response[0].userId.favoriteFoods;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return SizedBox(
      height: 290.0,
      child: FutureBuilder(
        future: foodController.getAllFood(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Food> data = snapshot.data as List<Food>;

            return SizedBox(
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 300.0,
                      autoPlay: false,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index, realIndex) {
                      bool exists = favouriteList.contains(data[index].id);
                      return GestureDetector(
                        onTap: () => Get.toNamed('/userFoodDetail', arguments: [
                          {"foodId": foodController.foodList[index].id},
                          {"name": foodController.foodList[index].name},
                          {"price": foodController.foodList[index].price},
                          {
                            "description":
                                foodController.foodList[index].description
                          },
                          {"image": foodController.foodList[index].image},
                          {"index": index},
                          {"foodCount": 1},
                        ]),
                        child: Container(
                          width: 265,
                          margin: EdgeInsets.only(
                            top: 20,
                            left: 0,
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
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SizedBox(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: PersistentHtpp.baseUrl +
                                            foodController
                                                .foodList[index].image,
                                        placeholder: (context, url) => Image(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/loading.gif',
                                            )),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ],
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
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs ' + data[index].price.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: kPrimary,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      exists
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: exists ? Colors.red : Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var cartData = {
                                        "index": index,
                                        "foodId": data[index].id,
                                        "name": data[index].name,
                                        "price": data[index].price,
                                        "description": data[index].description,
                                        "image": data[index].image,
                                        "foodCount": 1
                                      };
                                      bool response = cartController
                                          .addFoodInCart(cartData);
                                      if (response == false) {
                                        Get.snackbar(
                                          "Food",
                                          "Food already added to cart",
                                          icon: Icon(Icons.no_meals,
                                              color: Colors.white),
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.black,
                                          colorText: Colors.white,
                                          animationDuration:
                                              Duration(seconds: 1),
                                          dismissDirection:
                                              DismissDirection.horizontal,
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      } else {
                                        Get.toNamed('/addToCart',
                                            arguments: cartController.cartList);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/cartShop.png'),
                                          height: 20,
                                          width: 20),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
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
