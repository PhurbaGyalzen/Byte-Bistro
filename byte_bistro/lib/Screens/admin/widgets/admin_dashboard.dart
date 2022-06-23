import 'package:byte_bistro/Screens/admin/widgets/add_food.dart';
import 'package:byte_bistro/Screens/admin/widgets/view_food.dart';
import 'package:byte_bistro/Screens/category/category_screen.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/Services/storage_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: ListTile(
                  title: Text('Change Password'),
                  leading: Image(
                    image: AssetImage('assets/images/padlock.png'),
                    width: 25,
                    height: 25,
                  ),
                ),
                value: 'Change Password',
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Cancel')),
                          TextButton(
                            onPressed: () async {
                              await Storage.remove('token');
                              await PersistentHtpp.storeAndSetHeader(token: '');
                              Get.offAllNamed('/login');
                            },
                            child: Text(
                              'Leave',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  title: Text('Logout'),
                  leading: Image(
                    image: AssetImage(
                      "assets/images/logout.png",
                    ),
                    width: 25,
                    height: 25,
                  ),
                ),
                value: 'logout',
              ),
            ];
          }),
        ],
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Get.offNamed('/adminProfile');
          },
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      backgroundColor: kPrimary,
      floatingActionButton: SpeedDial(
        activeBackgroundColor: Colors.red.shade400,
        backgroundColor: kPrimary.withOpacity(0.9),
        foregroundColor: kTextColor,
        activeForegroundColor: Colors.white,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 30),
        overlayColor: kTextColor.withOpacity(0.5),
        tooltip: 'Toggle menu',
        overlayOpacity: 0.05,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Image(
              image: AssetImage('assets/images/addFood.png'),
              width: 30,
              height: 30,
            ),
            backgroundColor: kPrimary,
            onTap: () => showMaterialDialog(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              // reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Categories',
                      style: Theme.of(context).textTheme.bodyText2),
                  CategoryScreen(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    ElevatedButton(
                        onPressed: () => Get.toNamed('/adminOrders'),
                        child: Text(
                          'Orders',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimary.withOpacity(0.8),
                        ))
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  ViewFood(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// show dialog box from add_food.dart
  void showMaterialDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Dialog(
              insetAnimationCurve: Curves.fastOutSlowIn,
              insetAnimationDuration: Duration(seconds: 2),
              elevation: 10,
              insetPadding: EdgeInsets.all(10),
              backgroundColor: Colors.white,
              child: AddFood(),
            ),
          );
        });
  }
}
