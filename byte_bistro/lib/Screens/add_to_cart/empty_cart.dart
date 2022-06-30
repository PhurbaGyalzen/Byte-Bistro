
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EmptyCart extends StatelessWidget {
  const EmptyCart({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
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
          Image(image: AssetImage('assets/images/emptycart.gif', ), height: 350,),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text('Cart is empty. \n Please add some food.', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, letterSpacing: 0.4, wordSpacing: 2, height: 1.5, fontWeight: FontWeight.w600,),),
          ),
        ],
      )));
  }
}
