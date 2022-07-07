// CartFood
import 'dart:ui';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

import '../../../constants/colors.dart';

class CartFood extends StatelessWidget {
  CartFood({Key? key}) : super(key: key);
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
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
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kTextLightColor.withOpacity(0.05),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
                color: Color(0xFFB0CCE1).withOpacity(0.02),
              ),
            ],
          ),
          child: Obx(
            () => ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: cartController.cartList.length,
                itemBuilder: (context, index) => Slidable(
                      key: UniqueKey(),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          cartController.removeFoodFromList(index);
                        }),
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (value) {},
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.edit_outlined,
                            label: 'Remove Food ',
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            top: 20, right: 0, bottom: 10, left: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                              color: Color(0xFFB0CCE1).withOpacity(0.32),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/loading.gif',
                                    )),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                                imageUrl: PersistentHtpp.baseUrl +
                                    cartController.cartList[index]['image'],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartController.cartList[index]['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  ("Rs ${cartController.cartList[index]['price'].toString()}"),
                                  style: TextStyle(
                                    color: kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),

                            // Add and Remove Item
                            Row(
                              children: [
                                InkWell(
                                  onTap: () =>
                                      cartController.removeFoodCount(index),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: kPrimary.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/minusBorder.png'),
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                  ),
                                  child: Obx(() => Text(cartController
                                      .cartList[index]['foodCount']
                                      .toString())),
                                ),
                                InkWell(
                                  onTap: () {
                                    cartController.addFoodCount(index);
                                    cartController.updatePrice(index);
                                    // cartController.cartList[index]['price'] = 0;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: kPrimary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/add.png'),
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // specify type as Controller

                            //       .toString(),, // value is an instance of Controller.
                          ],
                        ),
                      ),
                    )),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/paymentSummary');
          },
          child: Text(
            'Proceed',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            primary: kPrimary,
          ),
        ),
      ],
    );
  }
}
