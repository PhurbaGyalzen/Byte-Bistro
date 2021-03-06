import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:byte_bistro/Screens/add_to_cart/add_to_cart.dart';
import 'package:byte_bistro/Screens/add_to_cart/empty_cart.dart';
import 'package:byte_bistro/Screens/add_to_cart/widgets/payment_summary.dart';
import 'package:byte_bistro/Screens/admin/widgets/add_food.dart';
import 'package:byte_bistro/Screens/admin/widgets/add_notification.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_food_detail.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_order_detail.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_orders.dart';
import 'package:byte_bistro/Screens/admin/widgets/empty_tab_item.dart';
import 'package:byte_bistro/Screens/admin/widgets/update_food.dart';
import 'package:byte_bistro/Screens/admin/widgets/view_food.dart';
import 'package:byte_bistro/Screens/contact_us.dart';
import 'package:byte_bistro/Screens/faq.dart';
import 'package:byte_bistro/Screens/license_section.dart';
import 'package:byte_bistro/Screens/privacy_policy.dart';
import 'package:byte_bistro/Screens/reset_password.dart';
import 'package:byte_bistro/Screens/admin/widgets/admin_dashboard.dart';
import 'package:byte_bistro/Screens/profile/admin_profile.dart';
import 'package:byte_bistro/Screens/profile/admin_profile_update.dart';
import 'package:byte_bistro/Screens/after_order.dart';
import 'package:byte_bistro/Screens/category/category_screen.dart';
import 'package:byte_bistro/Screens/change_password.dart';
import 'package:byte_bistro/Screens/profile/profile_screen.dart';
import 'package:byte_bistro/Screens/profile/user_profile.dart';
import 'package:byte_bistro/Screens/favourite/favourite.dart';

import 'package:byte_bistro/Screens/notification/admin_notification.dart';
import 'package:byte_bistro/Screens/notification/notification.dart';
import 'package:byte_bistro/Screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:byte_bistro/Screens/admin_order_history_list.dart';
import 'package:byte_bistro/Screens/order_sucess.dart';

import 'package:byte_bistro/Screens/qr_data.dart';
import 'package:byte_bistro/Screens/qr_scanner.dart';
import 'package:byte_bistro/Screens/set_new_password.dart';
import 'package:byte_bistro/Screens/signup_screen.dart';
import 'package:byte_bistro/Screens/home/home.dart';
import 'package:byte_bistro/Screens/home/widgets/food_detail_screen.dart';
import 'package:byte_bistro/Screens/swipe_qr_home.dart';

import 'package:byte_bistro/Screens/user_invoice_list.dart';
import 'package:byte_bistro/Screens/terms_and_conditions.dart';

import 'package:byte_bistro/Screens/verify_reset_password.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/Services/storage_service.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:byte_bistro/controller/favourite_controller.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/utils/str_decoder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Screens/admin/widgets/user_food_detail.dart';
import 'Screens/login_screen.dart';
import 'package:flutter/services.dart';

import 'constants/colors.dart';

Map<String, dynamic> tokenDecoded = {};
int tableNo = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon', // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Byte Bistro',
            channelDescription: "Your Order is Ready",
            defaultColor: const Color(0XFF9050DD),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            importance: NotificationImportance.High,
            enableVibration: true)
      ]);
  await dotenv.load(fileName: ".env");
  String? token = await Storage.get('token');
  print(token);
  if (token != "" && token != null) {
    try {
      String payload = token.split('.')[1];
      tokenDecoded = jsonDecode(BaseSixtyFour.b64decode(payload));
    } catch (RangeError) {}
  }

  await PersistentHtpp.storeAndSetHeader();
  runApp(ByteBistro());
}

class ByteBistro extends StatelessWidget {
  ByteBistro({Key? key}) : super(key: key);
  final LoggedUserInfoController loggedUserInfoController =
      Get.put(LoggedUserInfoController());

  final CartController cartController = Get.put(CartController());
  final CategoryController controller = Get.put(CategoryController());
  final FoodController foodController = Get.put(FoodController());
  final FavouriteController favouriteController =
      Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    String initialRoute = '/login';
    if (tokenDecoded['username'] != null) {
      initialRoute = '/home';
      if (tokenDecoded['isAdmin']) {
        initialRoute = '/adminScreen';
      }
    }
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
      initialRoute: dotenv.env['INITIAL_ROUTE'] ?? initialRoute,
      // initialRoute: '/adminScreen',

      debugShowCheckedModeBanner: false,
      title: 'Byte Bistro',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/reset_password', page: () => ForgetPasswordScreen()),
        GetPage(
            name: '/verify_reset_password', page: () => VerifyResetPassword()),
        GetPage(name: '/user_invoice_list', page: () => UserInvoiceList()),
        GetPage(name: '/profile_screen', page: () => ProfileScreen()),
        GetPage(
            name: '/admin_order_history_list',
            page: () => AdminOrderHistoryList()),
        GetPage(name: '/adminScreen', page: () => AdminDashboard()),
        GetPage(
            name: '/adminProfileUpdateForm',
            page: () => AdminProfileUpdateForm()),
        GetPage(name: '/adminProfile', page: () => AdminProfilePage()),
        GetPage(name: '/adminNotification', page: () => AdminNotification()),
        GetPage(name: '/adminOrders', page: () => AdminOrders()),
        GetPage(name: '/adminFoodDetail', page: () => AdminFoodDetail()),
        GetPage(name: '/adminOrderDetail', page: () => AdminOrderDetail()),
        GetPage(name: '/detail_page_dish', page: () => IndividualItemScreen()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/set_new_password', page: () => SetNewPassword()),
        GetPage(name: '/changePassword', page: () => ChangePassword()),
        GetPage(name: '/qrscan', page: () => QrScannerScreen()),
        GetPage(name: '/after-order', page: () => AfterOrderScreen()),
        GetPage(name: '/orderSucess', page: () => OrderSucess()),
        GetPage(name: '/addFood', page: () => AddFood()),
        GetPage(name: '/viewFood', page: () => ViewFood()),
        GetPage(name: '/notification', page: () => NotificationPage()),
        GetPage(name: '/dataScreen', page: () => QrDataScreen()),
        GetPage(name: '/swipeHome', page: () => SwipeHome()),
        GetPage(name: '/addToCart', page: () => AddToCart()),
        GetPage(name: '/emptyCart', page: () => EmptyCart()),
        GetPage(name: '/notification', page: () => NotificationPage()),
        GetPage(name: '/addNotification', page: () => AddNotification()),
        GetPage(name: '/adminNotification', page: () => AdminNotification()),
        GetPage(name: '/favourite', page: () => FavouritePage()),
        GetPage(name: '/categoryScreen', page: () => CategoryScreen()),
        GetPage(name: '/onBoardingScreen', page: () => OnBoardingScreen()),
        GetPage(name: '/userProfilePage', page: () => UserProfilePage()),
        GetPage(name: '/updateFood', page: () => UpdateFood()),
        GetPage(name: '/userFoodDetail', page: () => UserFoodDetail()),
        GetPage(name: '/profileScreen', page: () => ProfileScreen()),
        GetPage(name: '/licenseSection', page: () => LicenseSection()),
        GetPage(name: '/termsAndConditions', page: () => TermsAndCondition()),
        GetPage(name: '/privacyPolicy', page: () => PrivacyPolicy()),
        GetPage(name: '/faq', page: () => Faq()),
        GetPage(name: '/contactUs', page: () => ContactUs()),
        GetPage(name: '/paymentSummary', page: () => PaymentSummary()),
        GetPage(name: '/pendingOrder', page: () => PaymentSummary()),
        GetPage(name: '/emptyTabItem', page: () => EmptyTabItem()),
      ],
    );
  }
}
