import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyTabItem extends StatelessWidget {
  const EmptyTabItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(
          child: Image(
            image: AssetImage(
              'assets/images/foodEmpty.gif',
            ),
            height: 350,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'No food available',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 0.4,
              wordSpacing: 2,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ));
  }
}
