// CartFood
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../constants/colors.dart';

class CartFood extends StatelessWidget {
  CartFood({Key? key, required this.cartList}) : super(key: key);
  final CartController cartController = Get.put(CartController());

  List<dynamic> cartList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        // height: MediaQuery.of(context).size.height,
        height: 550,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Your Cart',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Food',
                style: TextStyle(fontSize: 20, color: kPrimary),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                top: 20,
                right: 10,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                    color: Color(0xFFB0CCE1).withOpacity(0.2),
                  ),
                ],
              ),
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) => Slidable(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(
                                top: 20, right: 0, bottom: 10, left: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                  color: Color(0xFFB0CCE1).withOpacity(0.32),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image(
                                    image: NetworkImage(PersistentHtpp.baseUrl +
                                      cartList[index]['image']),
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartList[index]['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kTextColor,
                                        height: 1.5,
                                      ),
                                    ),
                                    // Text(
                                    //   (cartList[index]['price'].toString())
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //     color: kTextLightColor,
                                    //     height: 1.5,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // GestureDetector(
                                    //   onTap: () => cartList
                                    //       .removeAt(index),
                                    //   child: Image(
                                    //     color: Colors.red.withOpacity(0.8),
                                    //     image: AssetImage(
                                    //         'assets/images/delete.png'),
                                    //     height: 20,
                                    //     width: 20,
                                    //   ),
                                    // )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: kPrimary.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: GestureDetector(
                                          onTap: () =>
                                              cartController.minusQuantity(),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/minusBorder.png'),
                                            height: 20,
                                            width: 20,
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                      ),
                                      child: GetBuilder<CartController>(
                                        // specify type as Controller
                                        init:
                                            CartController(), // intialize with the Controller
                                        builder: (value) => Text(cartController
                                                .foodQuantity.value
                                                .toString()
                                            //       .toString(),, // value is an instance of Controller.
                                            ),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: kPrimary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: GestureDetector(
                                          onTap: () {
                                            cartController.addQuantity();
                                            cartController.updatePrice(
                                                cartList[index]['price']);
                                          },
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/add.png'),
                                            height: 20,
                                            width: 20,
                                          ),
                                        )),
                                  ],
                                ),
                                GetBuilder<CartController>(
                                    // specify type as Controller
                                    init:
                                        CartController(), // intialize with the Controller
                                    builder: (value) => Text(
                                          (cartList[index]['price'] *
                                                  cartController
                                                      .foodQuantity.value)
                                              .toString(),
                                          style: TextStyle(
                                            color: kTextColor,
                                            height: 1.5,
                                          ),
                                        )
                                    //       .toString(),, // value is an instance of Controller.
                                    ),
                              ],
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
