import 'package:byte_bistro/Screens/home/home.dart';
import 'package:byte_bistro/Screens/home/widgets/individual_item.dart';
import 'package:flutter/material.dart';

import 'Screens/home_page.dart';
import 'Screens/login_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ByteBistro());
}

class ByteBistro extends StatelessWidget {
  const ByteBistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      initialRoute: '/login',
      // '/individual_item': (context) => const IndividualItem(),
      debugShowCheckedModeBanner: false,
      title: 'Byte Bistro',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        
        '/individual': (context) => const IndividualItem(),
      },
    );
  }
}
