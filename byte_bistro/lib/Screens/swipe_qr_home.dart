import 'package:byte_bistro/Screens/home/home.dart';
import 'package:byte_bistro/Screens/qr_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SwipeHome extends StatefulWidget {
  @override
  _SwipeHomeState createState() => _SwipeHomeState();
}

class _SwipeHomeState extends State<SwipeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [HomePage(), QrScannerScreen()],
    ));
  }
}
