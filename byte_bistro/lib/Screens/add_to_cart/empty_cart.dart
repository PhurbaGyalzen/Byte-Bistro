
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EmptyCart extends StatelessWidget {
  const EmptyCart({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
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
      body: Center(child: Text('The cart is empty 😢')));
  }
}
