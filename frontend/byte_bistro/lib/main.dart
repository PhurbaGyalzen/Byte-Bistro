import 'package:flutter/material.dart';

import 'Screens/food_detail_screen.dart';

void main() {
  runApp(Byte_Bistro());
}

class Byte_Bistro extends StatelessWidget {
  const Byte_Bistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/details',
      routes: {
        '/details': (context) => const IndividualItem(),
      },
    );
  }
}
