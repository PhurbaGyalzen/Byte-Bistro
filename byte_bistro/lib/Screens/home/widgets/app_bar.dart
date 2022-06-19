import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget {
  final String leadingIcon;
  // ignore: prefer_typing_uninitialized_variables
  final IconButton trailingIcon;
  final String titleFirstName;
  final String titleSecondName;
  const BuildAppBar(
      {Key? key,
      required this.leadingIcon,
      required this.trailingIcon,
      required this.titleFirstName,
      required this.titleSecondName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(leadingIcon),
              height: 20,
              width: 20,
            ),
            Text.rich(TextSpan(
                text: titleFirstName,
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 0.5),
                children: [
                  TextSpan(
                      text: titleSecondName,
                      style: TextStyle(
                          color: kPrimary,
                          fontSize: 20,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold)),
                ])),
            // trailingIcon,
            SizedBox(
              height: 35,
              width: 35,
              child: trailingIcon,
            ),
          ],
        ));
  }
}
