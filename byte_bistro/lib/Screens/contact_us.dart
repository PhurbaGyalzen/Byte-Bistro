import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Get.toNamed('/profileScreen')),
          title: Text(
            'Contact Us',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: kPrimary),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Column(),
          ),
        ),
      ),
    );
  }
}
