import 'package:flutter/material.dart';

import 'Screens/home_page.dart';
import 'Screens/login_screen.dart';

void main() {
  runApp(const ByteBistro());
}

class ByteBistro extends StatelessWidget {
  const ByteBistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      initialRoute: '/login',
      // initialRoute: '/individual_item',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home_screen': (context) => const HomeScreen(),
        
        // '/individual_item': (context) => const IndividualItem(),
      },
    );
  }
}
