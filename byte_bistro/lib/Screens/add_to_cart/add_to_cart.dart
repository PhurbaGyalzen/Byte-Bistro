import 'package:byte_bistro/Screens/add_to_cart/widgets/cart_food.dart';
import 'package:byte_bistro/Screens/add_to_cart/widgets/payment_summary.dart';
import 'package:byte_bistro/constants/colors.dart';
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
    final cartList = Get.arguments;
    return Scaffold(
      backgroundColor: kPrimary,
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
                CartFood(
                  cartList: cartList,
                ),
                PaymentSummary(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
