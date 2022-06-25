// ignore_for_file: deprecated_member_use

import 'package:byte_bistro/Screens/profile/admin_profile_update.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

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
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/adminScreen'),
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 26, top: 15, right: 26),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: FutureBuilder(
                  future: userController.getLoggedUserInfo(),
                  builder: (context, snapshot) {
                    LoggedUserInfo? data = snapshot.data as LoggedUserInfo?;
                    if (snapshot.hasData) {
                      return Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                               NetworkImage( PersistentHtpp.baseUrl
                      + data!.profile,
                    ),
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
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
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
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            SizedBox(
              height: 30,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: OutlinedButton(
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
                                      style: OutlinedButton.styleFrom(
                                      // primary: Colors.orange,
                                      primary: Colors.red,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 1.5,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
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
                                        letterSpacing: 1,
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
                                        letterSpacing: 1,
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
                                        letterSpacing: 1,
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
                                        letterSpacing: 1,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
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
