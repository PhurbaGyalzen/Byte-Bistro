import 'package:byte_bistro/Screens/add_to_cart/add_to_cart.dart';
import 'package:byte_bistro/Screens/admin/widgets/add_food.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_order_detail.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_orders.dart';
import 'package:byte_bistro/Screens/admin/widgets/view_food.dart';

import 'package:byte_bistro/Screens/admin/widgets/admin_dashboard.dart';
import 'package:byte_bistro/Screens/admin_profile.dart';
import 'package:byte_bistro/Screens/admin_profile_update.dart';
import 'package:byte_bistro/Screens/after_order.dart';
import 'package:byte_bistro/Screens/category/category_screen.dart';
import 'package:byte_bistro/Screens/edit_profile.dart';
import 'package:byte_bistro/Screens/invoice_detail_page.dart';
import 'package:byte_bistro/Screens/notification/admin_notification.dart';
import 'package:byte_bistro/Screens/notification/notification.dart';
import 'package:byte_bistro/Screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:byte_bistro/Screens/order_history_list_admin.dart';
import 'package:byte_bistro/Screens/order_sucess.dart';

import 'package:byte_bistro/Screens/qr_data.dart';
import 'package:byte_bistro/Screens/qr_scanner.dart';
import 'package:byte_bistro/Screens/signup_screen.dart';
import 'package:byte_bistro/Screens/home/home.dart';
import 'package:byte_bistro/Screens/home/widgets/individual_item.dart';
import 'package:byte_bistro/Screens/swipe_qr_home.dart';
import 'package:byte_bistro/Screens/user_order_history_list.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'globals.dart' as globals;
import 'Screens/login_screen.dart';
import 'package:byte_bistro/Screens/Category_momo.dart';
import 'package:flutter/services.dart';

import 'Screens/user_history_detail.dart';
import 'constants/colors.dart';

int tableNo = 0;
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await PersistentHtpp.setTokenHeader();
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
        primaryColor: Color(0xFFFFC61F),
        // brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
        ).copyWith(
          secondary: kTextColor,
        ),

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
            color: kTextColor,
          ),
          headline2: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            height: 1.5,
            color: kTextColor,
          ),
          bodyText1: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            height: 1.5,
            color: kTextColor,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: kTextLightColor,
          ),
        ),
      ),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      title: 'Byte Bistro',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(
            name: '/orderHistory_user_list', page: () => OrderHistoryUser()),
        GetPage(name: '/order_history_admin', page: () => OrderHistoryAdmin()),
        GetPage(name: '/invoice_detail', page: () => InvoiceDetail()),
        GetPage(name: '/order_detail', page: () => OrderDetail()),
        // GetPage(name: '/edit_profile', page: () => EditProfilePage()),
        GetPage(name: '/CategoryMoMo', page: () => MOMO()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        // GetPage(name: '/signup', page: () =>ProfileScreen()),
        GetPage(
            name: '/adminProfileUpdateForm',
            page: () => AdminProfileUpdateForm()),
        GetPage(name: '/adminProfile', page: () => AdminProfilePage()),

        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/individual', page: () => IndividualItem()),
        GetPage(name: '/qrscan', page: () => QrScannerScreen()),
        GetPage(name: '/after-order', page: () => AfterOrderScreen()),
        GetPage(name: '/orderSucess', page: () => OrderSucess()),
        GetPage(name: '/addFood', page: () => AddFood()),
        GetPage(name: '/viewFood', page: () => ViewFood()),
        GetPage(name: '/adminScreen', page: () => AdminDashboard()),
        GetPage(name: '/dataScreen', page: () => QrDataScreen()),
        GetPage(name: '/swipeHome', page: () => SwipeHome()),
        GetPage(name: '/addToCart', page: () => AddToCart()),
        GetPage(name: '/notification', page: () => NotificationPage()),
        GetPage(name: '/adminNotification', page: () => AdminNotification()),
        // GetPage(name: '/profileScreen', page: () => ProfileScreen()),

        GetPage(name: '/categoryScreen', page: () => CategoryScreen()),
        GetPage(name: '/onBoardingScreen', page: () => OnBoardingScreen()),
        GetPage(name: '/adminOrders', page: () => AdminOrders()),
        GetPage(name: '/adminOrderDetail', page: () => AdminOrderDetail()),
        GetPage(name: '/editProfilePage', page: () => EditProfilePage()),
      ],
    );
  }
}
