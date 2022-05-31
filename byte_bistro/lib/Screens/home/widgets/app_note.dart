import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class AppNote extends StatelessWidget {
  const AppNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, Sunil',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Welcome back!',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
