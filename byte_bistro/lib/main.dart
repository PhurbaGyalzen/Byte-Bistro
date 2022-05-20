import 'package:byte_bistro/Screens/admin/widgets/add_food.dart';
import 'package:byte_bistro/Screens/admin_screen.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_dashboard.dart';
import 'package:byte_bistro/Screens/after_order.dart';
import 'package:byte_bistro/Screens/qr_scanner.dart';
import 'package:byte_bistro/Screens/signup_screen.dart';
import 'package:byte_bistro/Screens/home/home.dart';
import 'package:byte_bistro/Screens/home/widgets/individual_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      title: 'Byte Bistro',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/individual', page: () => IndividualItem()),
        GetPage(name: '/qrscan', page: () => QrScannerScreen()),
        GetPage(name: '/after-order', page: () => AfterOrderScreen()),
        GetPage(name: '/admin', page: () => AdminDashboard()),
        GetPage(name: '/add-food', page: () => AddFood()),
        GetPage(name: '/adminScreen', page: () => Admin()),
      ],
    );
  }
}
