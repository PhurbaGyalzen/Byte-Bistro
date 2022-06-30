
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
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:const  [
          Image(image: AssetImage('assets/images/trolley.png', ), height: 150,),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Cart is empty. Please add some food.', style: TextStyle(fontSize: 20, letterSpacing: 0.2),),
          ),
        ],
      )));
  }
}
