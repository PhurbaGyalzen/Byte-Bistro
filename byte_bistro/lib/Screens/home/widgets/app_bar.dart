import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget {
  final String leadingIcon;
  final String trailingIcon;
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(leadingIcon),
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(
              width: 100,
            ),
            Text.rich(TextSpan(
                text: titleFirstName,
                style: TextStyle(fontSize: 20, letterSpacing: 0.5),
                children: [
                  TextSpan(
                      text: titleSecondName,
                      style: TextStyle(
                          color: kPrimary, fontSize: 20, letterSpacing: 0.5)),
                ])),
            SizedBox(
              width: 120,
            ),
            Expanded(
              child: Image(
                image: AssetImage(trailingIcon),
                height: 20,
                width: 20,
              ),
            )
          ],
        ));
  }
}