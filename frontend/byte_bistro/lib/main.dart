import 'package:byte_bistro/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'Screens/login_screen.dart';

void main() {
  runApp(Byte_Bistro());
}

class Byte_Bistro extends StatelessWidget {
  const Byte_Bistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signup',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}
