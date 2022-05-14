import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({Key? key}) : super(key: key);

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
                image: AssetImage('assets/images/menu.png'),
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(
              width: 100,
            ),
            Text.rich(TextSpan(
                text: 'Byte',
                style: TextStyle(fontSize: 20, letterSpacing: 0.5),
                children: [
                  TextSpan(
                      text: ' Bistro',
                      style: TextStyle(
                          color: kPrimary, fontSize: 20, letterSpacing: 0.5)),
                ])),
            SizedBox(
              width: 120,
            ),
            Expanded(
              child: Image(
                image: AssetImage('assets/images/notification2.png'),
                height: 20,
                width: 20,
              ),
            )
          ],
        ));
  }
}
