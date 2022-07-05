import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:byte_bistro/controller/favourite_controller.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/http_service.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserFoodDetail extends StatelessWidget {
  UserFoodDetail({Key? key}) : super(key: key);

  final data = Get.arguments;

  final CartController cartController = Get.find();
  final FavouriteController favouriteController = Get.find();
  final LoggedUserInfoController loggedUserInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  Map<String, dynamic> favData = {
                    "foodId": data[0]["foodId"],
                    "userId": loggedUserInfoController.userInfo[0].id,
                  };

                  var response =
                      await favouriteController.addFavourite(favData);
                  if (response == "success") {
                    Get.snackbar(
                      "Food",
                      "Food added to favourite",
                      icon: Icon(Icons.no_meals, color: Colors.white),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      animationDuration: Duration(seconds: 1),
                      dismissDirection: DismissDirection.horizontal,
                      snackPosition: SnackPosition.TOP,
                    );
                  } else if (response == 'already') {
                    Get.snackbar(
                      "Food",
                      "Food already added to favourite",
                      icon: Icon(Icons.no_meals, color: Colors.white),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      animationDuration: Duration(seconds: 1),
                      dismissDirection: DismissDirection.horizontal,
                      snackPosition: SnackPosition.TOP,
                    );
                  } else {
                    Get.snackbar(
                      "Error",
                      "Check Your connection",
                      icon: Icon(Icons.no_meals, color: Colors.white),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      animationDuration: Duration(seconds: 1),
                      dismissDirection: DismissDirection.horizontal,
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                  size: 25,
                )),
            SizedBox(
              width: 20,
            )
          ],
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Get.offAllNamed('/home')),
          title: Text(
            'Food Details',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: kPrimary),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
// food title
            Center(
              child: Text(
                data[1]['name'],
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: Colors.black,
                    wordSpacing: 5),
              ),
            ),
// food image
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
                top: 15,
                left: 10,
                right: 10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: PersistentHtpp.baseUrl + data[4]['image'],
                    placeholder: (context, url) => Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/loading.gif',
                        )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            //food tab

            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          height: 1.5)),
                  Text(data[2]['price'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: 0.4,
                      )),
                ],
              ),
            ),

            // food description
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
              ),
              child: Text('Detail',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, height: 1.5)),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 20,
                top: 5,
              ),
              child: SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(data[3]['description'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          height: 1.5)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 5,
                bottom: 5,
                right: 20,
              ),
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  var cartData = {
                    "index": data[5]['index'],
                    "foodId": data[0]['foodId'].toString(),
                    "name": data[1]['name'].toString(),
                    "price": data[2]['price'],
                    "description": data[3]['description'].toString(),
                    "image": data[4]['image'].toString(),
                    "foodCount": data[6]['foodCount']
                  };
                  bool response = cartController.addFoodInCart(cartData);
                  if (response == false) {
                    Get.snackbar(
                      "Food",
                      "Food already added to cart",
                      icon: Icon(Icons.no_meals, color: Colors.white),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.black,
                      colorText: Colors.white,
                      animationDuration: Duration(seconds: 1),
                      dismissDirection: DismissDirection.horizontal,
                      snackPosition: SnackPosition.TOP,
                    );
                  } else {
                    Get.toNamed('/addToCart',
                        arguments: cartController.cartList);
                  }
                },
                label: Text(
                  'Add to cart',
                  style: Theme.of(context).textTheme.headline1,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  primary: kPrimary,
                  textStyle: TextStyle(
                    color: kTextLightColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
