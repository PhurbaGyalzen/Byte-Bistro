// ignore_for_file: deprecated_member_use

import 'package:byte_bistro/Screens/profile/user_profile_update.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
        elevation: 0,
        title: Text(
          'Profile Details',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/profileScreen'),
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 26, right: 26),
        child: Column(
          children: [
            // SizedBox(
            //   height: 40,
            // ),
            Expanded(
              child: FutureBuilder(
                future: userController.getLoggedUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    LoggedUserInfo data = snapshot.data as LoggedUserInfo;

                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(height: 30,),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(150)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
                                    imageUrl:
                                        PersistentHtpp.baseUrl + data.profile,
                                    placeholder: (context, url) => Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/loading.gif',
                                        )),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
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
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Icon(
                                      Icons.verified_user,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:20.0),
                              child: Center(
                                child: SizedBox(
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
                                              UserProfileUpdateForm(
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
                                          letterSpacing: 2.2,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
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
                                        height: 1.5,
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
                                        height: 1.5,
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
                                        height: 1.5,
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
                                        height: 1.5,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 80,
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
