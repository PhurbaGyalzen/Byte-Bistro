import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class AppNote extends StatelessWidget {
  const AppNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, Sunil',
            style: TextStyle(
              height: 1.5,
              color: kTextColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Welcome back!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
