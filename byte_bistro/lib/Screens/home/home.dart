import 'package:byte_bistro/Screens/home/widgets/top_of_day.dart';
import 'package:flutter/material.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/Screens/home/widgets/app_bar.dart';
import 'package:byte_bistro/Screens/home/widgets/app_note.dart';
import 'package:byte_bistro/Screens/home/widgets/food_tab.dart';
import 'package:byte_bistro/Screens/home/widgets/tab_item.dart';
import 'package:byte_bistro/Screens/home/widgets/today_special.dart';
import 'package:hidable/hidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  final ScrollController scrollController = ScrollController();

  late final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(
      scrollController: scrollController,
    ),
    HomeScreen(
      scrollController: scrollController,
    ),
    HomeScreen(
      scrollController: scrollController,
    ),
    HomeScreen(
      scrollController: scrollController,
    ),
    HomeScreen(
      scrollController: scrollController,
    )
  ];
  void onItemTapped(int index) {
    print("on item tapped");
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: _widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: Hidable(
        controller: scrollController,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "$selectedIndex",
              backgroundColor: Colors.blue,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: "Inbox",
              backgroundColor: Colors.blue,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
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
  @override
  Widget build(BuildContext context) {
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
            children: [
              BuildAppBar(
                leadingIcon: 'assets/images/menu.png',
                trailingIcon: 'assets/images/notification.png',
                titleFirstName: 'Byte',
                titleSecondName: 'Bistro',
              ),
              AppNote(),
              FoodTab(),
              TabItem(),
              TodaySpecial(),
              TopOfDay(),
            ],
          ),
        ),
      ),
    );
  }
}
