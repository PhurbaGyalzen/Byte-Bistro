import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({Key? key}) : super(key: key);

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
                  borderRadius: BorderRadius.circular(40),
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
            itemCount: 5,
            itemBuilder: ((context, index) {
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
                      child: Image(
                          image: AssetImage('assets/images/buffMomo.jpg')),
                      constraints: BoxConstraints(
                        maxHeight: 50,
                        maxWidth: 50,
                      ),
                    ),
                    title: Text("Order id received from sanjib"),
                    subtitle: Text(
                      'items',
                      style: TextStyle(
                        fontSize: 12,
                        color: kTextColor.withOpacity(0.5),
                      ),
                    ),
                    trailing: Opacity(
                      opacity: 0.5,
                      child: GestureDetector(
                        // onTap: () => Get.bottomSheet(
                        //     NotificationDetail(order: cart),
                        //     isDismissible: false,
                        //     elevation: 20),
                        onTap: () => Get.offNamed('/adminOrders'),
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
