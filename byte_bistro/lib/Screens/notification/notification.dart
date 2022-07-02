import 'package:byte_bistro/Screens/notification/notificationTab1.dart';
import 'package:byte_bistro/Screens/notification/notificationTab2.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:byte_bistro/constants/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    // final response = notificationController.getAllNotification();
    // print(response);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimary,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kTextColor,
            ),
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
          title: Text(
            'My Notifications',
            style: TextStyle(color: kTextColor, fontSize: 16),
          ),
          bottom: TabBar(tabs: const [
            Tab(
              child: Text(
                'Offers',
                style: TextStyle(color: kTextColor),
              ),
            ),
            Tab(
              child: Text(
                'All',
                style: TextStyle(color: kTextColor),
              ),
            ),
          ]),
          actions: const [
            // Stack(children: [
            //   Padding(
            //     padding: EdgeInsets.only(right: 25, top: 5),
            //     child: Image(
            //       image: AssetImage('assets/images/notification.png'),
            //       height: 20,
            //       width: 20,
            //       color: kTextColor,
            //     ),
            //   ),
            //   Positioned(
            //     right: 20,
            //     top: 2,
            //     child: Container(
            //       padding: EdgeInsets.only(
            //         left: 5,
            //         right: 5,
            //       ),
            //       decoration: BoxDecoration(
            //         color: kTextColor,
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //       child: Text(
            //         '1',
            //         style: TextStyle(
            //           fontSize: 12,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ]),
          ],
        ),
        body: TabBarView(children: [
          // Container(
          //   child: Text('All'),
          // ),
          // Container(
          //   child: Text('All'),
          // )
          NotificationOffer(),
          NotificationNormal(),
        ]),
      ),
    );
  }
}
