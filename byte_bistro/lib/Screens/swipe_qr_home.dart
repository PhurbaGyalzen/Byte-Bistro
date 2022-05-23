import 'package:byte_bistro/Screens/home/home.dart';
import 'package:byte_bistro/Screens/qr_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SwipeHome extends StatefulWidget {
  @override
  _SwipeHomeState createState() => _SwipeHomeState();
}

class _SwipeHomeState extends State<SwipeHome> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // PageController pgCont = widget.pageController;
    return Scaffold(
        body: PageView(
      controller: pageController,
      children: [HomePage(), QrScannerScreen(pageController: pageController)],
    ));
  }
}
