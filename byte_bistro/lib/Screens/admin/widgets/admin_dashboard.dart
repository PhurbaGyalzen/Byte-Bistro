import 'package:byte_bistro/Screens/admin/widgets/add_food.dart';
import 'package:byte_bistro/Screens/admin/widgets/view_food.dart';
import 'package:byte_bistro/Screens/home/widgets/app_bar.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimary.withOpacity(0.9),
        hoverColor: kTextColor,
        foregroundColor: kTextColor,
        elevation: 10,
        tooltip: 'Add Food',
        onPressed: () => showMaterialDialog(),
        child: Text(
          '+',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            // padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 20,
                ),
                BuildAppBar(
                  leadingIcon: 'assets/images/menu.png',
                  trailingIcon: 'assets/images/notification.png',
                  titleFirstName: 'Admin',
                  titleSecondName: 'Dash',
                ),
                ViewFood(),
              ],
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
