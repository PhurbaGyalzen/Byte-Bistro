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
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage(image),
                  width: MediaQuery.of(context).size.width - 100,
                  height: MediaQuery.of(context).size.height - 370,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  wordSpacing: 0.3,
                  height: 1.5,
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.1,
                  wordSpacing: 0.5,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
