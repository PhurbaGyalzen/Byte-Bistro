import 'package:byte_bistro/Screens/add_to_cart/add_to_cart.dart';
import 'package:byte_bistro/Screens/admin/widgets/add_food.dart';
import 'package:byte_bistro/Screens/admin/widgets/view_food.dart';
// import 'package:byte_bistro/Screens/admin_screen.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_dashboard.dart';
import 'package:byte_bistro/Screens/after_order.dart';
import 'package:byte_bistro/Screens/notification/admin_notification.dart';
import 'package:byte_bistro/Screens/notification/notification.dart';
import 'package:byte_bistro/Screens/qr_data.dart';
import 'package:byte_bistro/Screens/qr_scanner.dart';
import 'package:byte_bistro/Screens/signup_screen.dart';
import 'package:byte_bistro/Screens/home/home.dart';
import 'package:byte_bistro/Screens/home/widgets/individual_item.dart';
import 'package:byte_bistro/Screens/swipe_qr_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'globals.dart' as globals;
import 'Screens/login_screen.dart';
import 'package:byte_bistro/Screens/Category_momo.dart';
import 'package:flutter/services.dart';

int tableNo = 0;
Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Color(0xFFFFC61F),

        // Define the default font family.
        fontFamily: ' San Francisco',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            height: 1.5,
          ),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      title: 'Byte Bistro',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/CategoryMoMo', page: () => MOMO()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/individual', page: () => IndividualItem()),
        GetPage(name: '/qrscan', page: () => QrScannerScreen()),
        GetPage(name: '/after-order', page: () => AfterOrderScreen()),
        // GetPage(name: '/admin', page: () => AdminDashboard()),
        GetPage(name: '/addFood', page: () => AddFood()),
        GetPage(name: '/viewFood', page: () => ViewFood()),
        GetPage(name: '/adminScreen', page: () => AdminDashboard()),
        GetPage(name: '/dataScreen', page: () => QrDataScreen()),
        GetPage(name: '/swipeHome', page: () => SwipeHome()),
        GetPage(name: '/addToCart', page: () => AddToCart()),
        GetPage(name: '/notification', page: () => NotificationPage()),
        GetPage(name: '/adminNotification', page: () => AdminNotification()),
      ],
    );
  }
}
