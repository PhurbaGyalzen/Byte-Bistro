import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text('I am notitication detial page'),
        ),
      ),
    );
  }
}
