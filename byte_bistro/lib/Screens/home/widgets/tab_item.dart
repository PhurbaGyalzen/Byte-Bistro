import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
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
  LoggedUserInfoController loggedUserInfoController =
      Get.put(LoggedUserInfoController());
  FavouriteController favouriteController = Get.put(FavouriteController());
  // print(loggedUserInfoController);
  List favouriteList = [];
  var loggedUser;

  @override
  void initState() {
    super.initState();
    getFavourite();
  }

  Future getUser() async {
    var user = await loggedUserInfoController.getLoggedUserInfo();
    setState(() {
      loggedUser = user;
    });
  }

  Future getFavourite() async {
    List<Favourite> response =
        await favouriteController.getUserFavourites("627fbfa1d464ffbeb80b985b");
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
                      autoPlay: true,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index, realIndex) {
                      bool exists = favouriteList.contains(data[index].id);
                      return GestureDetector(
                        onTap: () => Get.toNamed('/userFoodDetail', arguments: [
                          {"id": foodController.foodList[index].id},
                          {"name": foodController.foodList[index].name},
                          {"price": foodController.foodList[index].price},
                          {
                            "description":
                                foodController.foodList[index].description
                          },
                          {"image": foodController.foodList[index].image},
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
                                  Positioned(
                                    top: -20,
                                    right: -20,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          exists
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: exists
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                        onPressed: exists
                                            ? null
                                            : () {
                                                Map<String, dynamic> dataD = {
                                                  "foodId": data[index].id,
                                                  "userId":
                                                      "627fbfa1d464ffbeb80b985b"
                                                };
                                                print("Error");
                                                // print(data[index].id);
                                                var response =
                                                    favouriteController
                                                        .addFavourite(dataD);
                                                // print(response);
                                                final snackbarSucess = SnackBar(
                                                    content: Text(
                                                        'Added to favourites'));
                                                setState(() {
                                                  favouriteList
                                                      .add(data[index].id);
                                                });
                                                final snackbarFail = SnackBar(
                                                    content: Text(
                                                        'The item is already added to favourites'));

                                                if (response == "success") {
                                                  snackbarSucess;
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          snackbarSucess);
                                                } else {
                                                  snackbarFail;
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          snackbarSucess);
                                                }
                                              },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs ' + data[index].price.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
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
                                      cartController.cartList.add(cartData);
                                      Get.toNamed('/addToCart',
                                          arguments: cartController.cartList);
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
