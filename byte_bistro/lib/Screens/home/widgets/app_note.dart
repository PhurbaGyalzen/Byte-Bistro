import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNote extends StatelessWidget {
  AppNote({Key? key}) : super(key: key);
  final LoggedUserInfoController userController =
      Get.put(LoggedUserInfoController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userController.getLoggedUserInfo(),
        builder: (context, snapshot) {
          LoggedUserInfo? data = snapshot.data as LoggedUserInfo?;
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( "Hi! "+ 
                  data!.username,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            );
          } else {
            return Text('Loading...');
          }
        });
  }
}
