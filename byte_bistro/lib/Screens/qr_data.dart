import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrDataScreen extends StatelessWidget {
  // final String text;
  final table = Get.arguments as String;
  QrDataScreen({Key? key, title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(table),
            ),
            body: Container(
              child: Text(table),
              
            )));
  }
}
