import 'dart:math';

import 'package:byte_bistro/Screens/notification/admin_notification_data.dart';
import 'package:byte_bistro/Screens/notification/notification_detail.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class AdminNotification extends StatelessWidget {
  const AdminNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kTextColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Notifications',
          style: TextStyle(color: kTextColor, fontSize: 16),
        ),
        actions: [
          Stack(children: [
            Padding(
              padding: EdgeInsets.only(right: 25, top: 5),
              child: Image(
                image: AssetImage('assets/images/notification.png'),
                height: 20,
                width: 20,
                color: kTextColor,
              ),
            ),
            Positioned(
              right: 20,
              top: 2,
              child: Container(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                decoration: BoxDecoration(
                  color: kTextColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '1',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: notificationData.length,
            itemBuilder: ((context, index) {
              Cart cart = Cart.fromJson(notificationData[index]);
              String thumbSrc = cart.items[0].foodId.image;
              return Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 15,
                    bottom: 15,
                    right: 20,
                  ),
                  margin:
                      EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                        color: Color(0xFFB0CCE1).withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: ConstrainedBox(
                      child:
                          CircleAvatar(backgroundImage: NetworkImage(thumbSrc)),
                      constraints: BoxConstraints(
                        maxHeight: 50,
                        maxWidth: 50,
                      ),
                    ),
                    title: Text(
                        "Order (#${cart.id}) received from ${cart.userId.fullname}"),
                    subtitle: Text(
                      '${cart.items.length} items',
                      style: TextStyle(
                        fontSize: 12,
                        color: kTextColor.withOpacity(0.5),
                      ),
                    ),
                    trailing: Opacity(
                      opacity: 0.5,
                      child: GestureDetector(
                        onTap: () => Get.bottomSheet(NotificationDetail()),
                        // onTap: () => {},
                        child: Image(
                          height: 20,
                          width: 20,
                          image: AssetImage(
                            'assets/images/next.png',
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
          ),
        ),
      ),
    );
  }
}
