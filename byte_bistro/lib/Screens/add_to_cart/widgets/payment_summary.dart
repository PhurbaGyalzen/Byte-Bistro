//PaymentSummary
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../Services/http_service.dart';
import '../../../constants/colors.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = {
      "cartId": "98023gjhfsdfn",
      "items": [
        {"foodId": "yqhediufhw", "qty": 7},
        {"foodId": "yqhediufhw", "qty": 7}
      ],
      "total": 500.0,
      "promoCode": ""
    };

    CartController cartController = Get.find();
    List cartList = cartController.cartList;
    List items = [];

    var subTotal = 0;
    var tax = 0.13;
    var total = 0.0;

    for (int i = 0; i < cartList.length; i++) {
      subTotal = cartList[i]['price'] * cartList[i]['foodCount'];
      cartList[i]["subTotal"] = subTotal;
      total += subTotal;
      var item = {
        "foodId": "${cartList[i]['foodId']}",
        "qty": cartList[i]['foodCount']
      };

      items.add(item);
    }

    double grandTotal = (total * tax) + total;
    final LoggedUserInfoController userController = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Conform Cart',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/addToCart'),
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // food detail
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
                child: ListView.builder(
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

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Qty',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kTextColor,
                                        height: 1.5,
                                      ),
                                    ),
                                    Text(
                                      (cartList[index]['foodCount'].toString()),
                                      style: TextStyle(
                                        color: kTextColor,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sub Total',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kTextColor,
                                        height: 1.5,
                                      ),
                                    ),
                                    Text(
                                      (cartList[index]['subTotal'].toString()),
                                      style: TextStyle(
                                        color: kTextColor,
                                        height: 1.5,
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

              // payment details
              Container(
                padding:
                    EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Payment Summary',
                          style: Theme.of(context).textTheme.headline1,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total item',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            height: 1.5,
                          ),
                        ),
                        Text(cartList.length.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'VAT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            height: 1.5,
                          ),
                        ),
                        Text('13%'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Net Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            height: 1.5,
                          ),
                        ),
                        Text(total.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grand Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                            height: 1.5,
                          ),
                        ),
                        Text(grandTotal.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          bottom: 30,
                        ),
                        child: Text(
                          'Payment Method',
                          style: Theme.of(context).textTheme.headline1,
                        )),
                    InkWell(
                      onTap: () {
                        var response = cartController.addCart({
                          "userId": userController.userInfo[0].id.toString(),
                          "items": items,
                          "tableId": 1,
                        });
                        cartController.cartList.value = [];
                        Get.snackbar(
                          "Order Sucessfully Placed",
                          "Please wait for the order to be ready",
                          icon: Icon(Icons.check, color: Colors.white),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          animationDuration: Duration(seconds: 1),
                          dismissDirection: DismissDirection.horizontal,
                          snackPosition: SnackPosition.TOP,
                        );
                        Get.offNamed("/home");
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image(
                                image: AssetImage('assets/images/dollar.png'),
                                height: 30,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pay with Cash',
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _initPayment(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image:
                                    AssetImage('assets/images/esewa_logo.png'),
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pay with Esewa',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _initPayment(Map<String, dynamic> product) {
    // _initPayment(String product) {
    ESewaConfiguration esewaConfiguration = ESewaConfiguration(
        clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
        secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
        environment: ESewaConfiguration.ENVIRONMENT_TEST);

    ESewaPnp _esewaPnp = ESewaPnp(configuration: esewaConfiguration);

    ESewaPayment _payment = ESewaPayment(
        amount: product['total'],
        productName: "table Number",
        productID: product['cartId'],
        callBackURL: "http://100.102.33.101:3000/cart/");

    try {
      final _res = _esewaPnp.initPayment(payment: _payment);
      // print(_res);
      // Handle success
    } on ESewaPaymentException catch (e) {
      // Handle error
      // print(e.message);
    }
  }
}
