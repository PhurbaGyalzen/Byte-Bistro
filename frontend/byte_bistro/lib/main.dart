import 'package:flutter/material.dart';

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
      routes: {
        '/login': (context) => LoginScreen(),
        
      },
    );
  }
}
