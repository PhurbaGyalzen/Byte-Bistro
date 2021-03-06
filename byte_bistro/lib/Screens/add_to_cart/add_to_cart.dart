import 'package:badges/badges.dart';
import 'package:byte_bistro/Screens/add_to_cart/widgets/cart_food.dart';
import 'package:byte_bistro/Screens/add_to_cart/widgets/payment_summary.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    // final cartList = Get.arguments;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Cart Items',
            style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.offNamed('/home'),
          ),
          backgroundColor: kPrimary,
          foregroundColor: kTextColor,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CartFood(),
                  // PaymentSummary(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
