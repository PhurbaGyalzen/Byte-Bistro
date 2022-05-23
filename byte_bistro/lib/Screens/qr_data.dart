import 'package:byte_bistro/Screens/home/widgets/today_special.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrDataScreen extends StatelessWidget {
  // final String text;
  final table = Get.arguments as String;
  QrDataScreen({Key? key, title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(4.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                color: Colors.black54,
                size: 50,
              ),
            ),
            Text(
              "Table Number: $table",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
            IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black54,
                size: 50,
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            child: Padding(
          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
          child: Text(
            "What would you like to Order ?",
            style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        )),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Text(
            "Order Menu",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
        ),
        OrderMenu(),
      ],
    ))));
  }
}

class OrderMenu extends StatelessWidget {
  OrderMenu({Key? key, title}) : super(key: key);
  final tabIcon = [
    'momo.png',
    'noodles.png',
    'hamburger.png',
    'flatpizza.png',
    'coffee.png',
    'beer.png',
    'view.png',
  ];

  final tabText = [
    'Momo',
    'Noodles',
    'Burger',
    'Pizza',
    'Cock',
    'Beer',
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 6, 5, 5),
          child: TodaySpecial(),
        ));
  }
}
