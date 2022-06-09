import 'package:flutter/material.dart';

class OnboardingInfo extends StatelessWidget {
  OnboardingInfo(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);
  String image;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Image(image: AssetImage(image)),
              Text(title),
              Text(description),
            ],
          ),
        ],
      ),
    );
  }
}
