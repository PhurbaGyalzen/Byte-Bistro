import 'package:byte_bistro/Screens/home/widgets/tab_item.dart';
import 'package:byte_bistro/Screens/home/widgets/top_of_day.dart';
import 'package:byte_bistro/Screens/profile/profile_screen.dart';
import 'package:byte_bistro/Screens/qr_scanner.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:byte_bistro/Screens/home/widgets/app_bar.dart';
import 'package:byte_bistro/Screens/home/widgets/app_note.dart';
import 'package:byte_bistro/Screens/home/widgets/food_tab.dart';
import 'package:byte_bistro/Screens/home/widgets/today_special.dart';
import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  final ScrollController scrollController = ScrollController();

  late final List<Widget> widgetOptions = <Widget>[
    HomeScreen(
      scrollController: scrollController,
    ),
    HomeScreen(
      scrollController: scrollController,
    ),
    QrScannerScreen(),
    HomeScreen(
      scrollController: scrollController,
    ),
    ProfileScreen(
      scrollController: scrollController,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: widgetOptions[selectedIndex],
        bottomNavigationBar: Hidable(
          controller: scrollController,
          child: ConvexAppBar(
            top: -35.0,
            style: TabStyle.fixedCircle,
            activeColor: kPrimary,
            backgroundColor: Colors.black.withOpacity(0.01),
            items: const [
              TabItem(
                activeIcon: Icon(
                  Icons.home,
                  size: 25,
                ),
                icon: Icon(
                  Icons.home_outlined,
                  size: 25,
                ),
              ),
              TabItem(
                  activeIcon: Icon(Icons.mail),
                  icon: Icon(
                    Icons.mail_outline,
                    size: 25,
                  )),
              TabItem(
                icon: Icon(
                  Icons.qr_code,
                  size: 30,
                ),
              ),
              TabItem(
                activeIcon: Icon(Icons.shopping_cart),
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 25,
                ),
              ),
              TabItem(
                activeIcon: Icon(Icons.person),
                icon: Icon(
                  Icons.person_outlined,
                  size: 25,
                ),
              ),
            ],
            initialActiveIndex: 2, //optional, default as 0
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FoodController foodController = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
    final response = foodController.getAllFood();
    print(response);
    return SafeArea(
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              BuildAppBar(
                leadingIcon: 'assets/images/menu.png',
                trailingIcon: 'assets/images/notification.png',
                titleFirstName: 'Byte',
                titleSecondName: 'Bistro',
              ),
              AppNote(),
              FoodTab(),
              TabItemDetail(),
              TodaySpecial(),
              TopOfDay(),
            ],
          ),
        ),
      ),
    );
  }
}
