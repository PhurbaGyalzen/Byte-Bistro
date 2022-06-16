// ignore_for_file: deprecated_member_use

import 'package:byte_bistro/Screens/admin_profile_update.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  LoggedUserInfoController userController = Get.put(LoggedUserInfoController());
  final formkey = GlobalKey<FormState>();
  var fullName = '';
  var bio = '';
  var email = '';
  var address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 26, top: 15, right: 26),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/buffMomo.jpg'),
                    radius: 60,
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
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: userController.getLoggedUserInfo(),
                builder: (context, snapshot) {
                  print("snapshot");
                  print(snapshot);
                  print("snapshot.hasData ${snapshot.hasData}");
                  print("snapshot.data ${snapshot.data}");
                  if (snapshot.hasData) {
                    LoggedUserInfo data = snapshot.data as LoggedUserInfo;
                    print(" fav ${data.favoriteFoods}");

                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color(0xFFFFC61F),
                                ),
                                SizedBox(
                                  width: 30,
                                ),

                                // Text(data.bio==""? "Your bio is empty." : data.bio)
                                Expanded(
                                  child: Text(
                                    data.fullname == ""
                                        ? "Add fullname"
                                        : data.fullname,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w500,
                                        letterSpacing: 2.2,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              // height: 20,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: Color(0xFFFFC61F),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Text(
                                    data.email == "" ? "Add email" : data.email,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w500,
                                        letterSpacing: 2.2,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              // height: 20,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Color(0xFFFFC61F),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Text(
                                    data.address,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w500,
                                        letterSpacing: 2.2,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              // height: 20,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Color(0xFFFFC61F),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Text(
                                    data.bio == "" ? "Add bio" : data.bio,
                                    overflow: TextOverflow.clip,
                                    // maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w500,
                                        letterSpacing: 2.2,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 120,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        Get.toNamed("/adminScreen"),
                                    style: OutlinedButton.styleFrom(
                                      // primary: Colors.orange,
                                      primary: Colors.red,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: Text(
                                      "Back",
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
                                      setState(
                                        () {
                                          fullName = data.fullname;
                                          email = data.email;
                                          address = data.address;
                                          bio = data.bio;
                                        },
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdminProfileUpdateForm(
                                            bio: bio,
                                            fullName: fullName,
                                            address: address,
                                            email: email,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFFFC61F),
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
