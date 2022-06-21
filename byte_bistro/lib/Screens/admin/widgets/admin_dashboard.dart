import 'package:byte_bistro/Screens/admin/widgets/add_food.dart';
import 'package:byte_bistro/Screens/admin/widgets/view_food.dart';
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
          SpeedDialChild(
            child: Image(
              image: AssetImage('assets/images/addUser.png'),
              width: 30,
              height: 30,
            ),
            backgroundColor: kPrimary,
          ),
          SpeedDialChild(
            child: Image(
              image: AssetImage('assets/images/addNotification.png'),
              width: 30,
              height: 30,
            ),
            backgroundColor: kPrimary,
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.offNamed('/adminProfile');
                        },
                        child: Image.asset(
                          "assets/images/account.png",
                          height: 25,
                          width: 25,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text.rich(
                        TextSpan(
                          text: "Admin",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 0.5),
                          children: const [
                            TextSpan(
                                text: "DashBoard",
                                style: TextStyle(
                                    color: kPrimary,
                                    fontSize: 20,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      PopupMenuButton(itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                SizedBox(
                                  width: 5,
                                ),
                                Image(
                                  image:
                                      AssetImage('assets/images/padlock.png'),
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Change Password'),
                              ],
                            ),
                            value: 'logout',
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                logoutWidget(),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Logout'),
                              ],
                            ),
                            value: 'logout',
                          ),
                        ];
                      }),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // Text('Categories',
                  //     style: Theme.of(context).textTheme.bodyText2),
                  // CategoryScreen(),
                  // SizedBox(
                  //   height: 30,
                  // ),
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

class logoutWidget extends StatelessWidget {
  const logoutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      // onTap: () {
      //   // final response = await PersistentHtpp.get('food');
      //   // print(response.body);
      //   // await Storage.setObject('token-val', {'value1': 1});
      //   // print('token-val');
      //   // print(await Storage.getObject('token-val'));
      //    AlertDialog alert = AlertDialog(
      //     title: const Text('AlertDialog Title'),
      //     content: const Text('AlertDialog description'),
      //     actions: <Widget>[
      //       TextButton(
      //         onPressed: () =>
      //             Navigator.pop(context, 'Cancel'),
      //         child: const Text('Cancel'),
      //       ),
      //       TextButton(
      //         onPressed: () async {
      //           await Storage.remove('token');
      //           await PersistentHtpp.storeAndSetHeader(
      //               token: '');
      //           Get.offAllNamed('/login');
      //         },
      //         child: const Text('OK'),
      //       ),
      //     ],
      //   );
      // },
      child: Image.asset(
        "assets/images/logout.png",
        height: 20,
        width: 20,
      ),
    );
  }
}
