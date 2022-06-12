// ignore_for_file: deprecated_member_use

import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SettingsUI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Setting UI",
//       home: EditProfilePage(),
//     );
//   }
// }

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  LoggedUserInfoController userController = Get.put(LoggedUserInfoController());
  final formkey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 15, right: 16),
          child: FutureBuilder(
            future: userController.getLoggedUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                LoggedUserInfo data = snapshot.data as LoggedUserInfo;

                return ListView(
            children: [
              Center(
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/buffMomo.jpg'),
                      radius: 70,
                    ),

                   
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () {},

                      

                      style: OutlinedButton.styleFrom(
                        // primary: Colors.orange,
                        primary: Colors.red,
                        shape: const StadiumBorder(),
                      ),

                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Scaffold(
                              body: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 16, top: 50, right: 16),
                                  child: Form(
                                    key: formkey,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/images/buffMomo.jpg'),
                                                radius: 70,
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor,
                                                    ),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 3),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintText: "Fullname",
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 3),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintText: "E-mail",
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 3),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintText: "Phone",
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 3),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintText: "Address",
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/edit_profile');
                                              },
                                              style: OutlinedButton.styleFrom(
                                                // primary: Colors.orange,
                                                primary: Colors.red,
                                                shape: const StadiumBorder(),
                                              ),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    letterSpacing: 2.2,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                // primary: Colors.orange,
                                                primary: Theme.of(context)
                                                    .primaryColor,
                                                shape: const StadiumBorder(),
                                              ),
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    letterSpacing: 2.2,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
