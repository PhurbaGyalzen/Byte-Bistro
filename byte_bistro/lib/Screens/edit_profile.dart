// ignore_for_file: deprecated_member_use

import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
  final TextEditingController bioController = TextEditingController();
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
              height: 10,
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
                                      color: Colors.black
                                    ),
                                  
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
                                      color: Colors.black
                                    ),
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
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.phone_android,
                            //       color: Color(0xFFFFC61F),
                            //     ),
                            //     SizedBox(
                            //       width: 30,
                            //     ),
                            //     Text(
                            //       data.phones.isEmpty
                            //           ? "Add phone number"
                            //           : data.phones[0].toString(),
                            //       style:
                            //           Theme.of(context).textTheme.headline6,
                            //     )
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // const Divider(
                            //   // height: 20,
                            //   thickness: 1,
                            //   indent: 0,
                            //   endIndent: 0,
                            //   color: Color(0xFFFFC61F),
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
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
                                    data.address == ""
                                        ? "Add address"
                                        : data.address,
                                        overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.w500,
                                      letterSpacing: 2.2,
                                      color: Colors.black
                                    ),
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
                                    // maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 18,
                                      // fontWeight: FontWeight.w500,
                                      letterSpacing: 2.2,
                                      color: Colors.black
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 90,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: OutlinedButton(
                                    onPressed: () => Get.toNamed("/home"),
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
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Scaffold(
                                            body: SingleChildScrollView(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 26,
                                                    top: 50,
                                                    right: 26),
                                                child: Form(
                                                  key: formkey,
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: Stack(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'assets/images/buffMomo.jpg'),
                                                              radius: 70,
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              right: 0,
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    width: 4,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .scaffoldBackgroundColor,
                                                                  ),
                                                                  color: Color(
                                                                      0xFFFFC61F),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  color: Colors
                                                                      .white,
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
                                                        validator:
                                                            RequiredValidator(
                                                                errorText:
                                                                    '*required'),
                                                        controller:
                                                            fullnameController,
                                                        // initialValue:
                                                        //     data.fullname,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          hintText:
                                                              data.fullname,
                                                          labelText: 'Fullname',
                                                          hintStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormField(
                                                        validator:
                                                            MultiValidator(
                                                          [
                                                            EmailValidator(
                                                              errorText:
                                                                  'enter a valid email address',
                                                            ),
                                                            RequiredValidator(
                                                              errorText:
                                                                  '*required',
                                                            ),
                                                          ],
                                                        ),
                                                        controller:
                                                            emailController,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          labelText: 'E-mail',
                                                          hintText: data.email,
                                                          hintStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      // TextFormField(
                                                      //   validator:
                                                      //       RequiredValidator(
                                                      //           errorText:
                                                      //               '*required'),
                                                      //   controller:
                                                      //       phoneController,
                                                      //   decoration:
                                                      //       InputDecoration(
                                                      //     contentPadding:
                                                      //         EdgeInsets.only(
                                                      //             bottom: 3),
                                                      //     floatingLabelBehavior:
                                                      //         FloatingLabelBehavior
                                                      //             .always,
                                                      //     labelText: 'Phone',
                                                      //     hintText: (data
                                                      //                 .phones
                                                      //                 .toString() ==
                                                      //             '[]'
                                                      //         ? ""
                                                      //         : data.phones[0]
                                                      //             .toString()),
                                                      //     hintStyle:
                                                      //         TextStyle(
                                                      //       fontSize: 16,
                                                      //       fontWeight:
                                                      //           FontWeight
                                                      //               .normal,
                                                      //       color:
                                                      //           Colors.black,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 20,
                                                      // ),
                                                      TextFormField(
                                                        validator:
                                                            RequiredValidator(
                                                                errorText:
                                                                    '*required'),
                                                        controller:
                                                            addressController,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          labelText: 'Address',
                                                          hintText:
                                                              data.address,
                                                          hintStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormField(
                                                        validator:
                                                            RequiredValidator(
                                                                errorText:
                                                                    '*required'),
                                                        controller:
                                                            bioController,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          labelText: "Bio",
                                                          hintText: data.bio,
                                                          hintStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/editProfilePage');
                                                            },
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              // primary: Colors.orange,
                                                              primary:
                                                                  Colors.red,
                                                              shape:
                                                                  const StadiumBorder(),
                                                            ),
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      2.2,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              if (formkey
                                                                  .currentState!
                                                                  .validate()) {
                                                                Map<String,
                                                                        dynamic>
                                                                    data = {
                                                                  "fullname":
                                                                      fullnameController
                                                                          .text,
                                                                  "email":
                                                                      emailController
                                                                          .text,
                                                                  // "phones":
                                                                  //     [phoneController
                                                                  //         .text],
                                                                  "bio":
                                                                      bioController
                                                                          .text,
                                                                  "address":
                                                                      addressController
                                                                          .text,
                                                                };
                                                                String
                                                                    response =
                                                                    await LoggedUserInfoController
                                                                        .updateProfileInfo(
                                                                            data);

                                                                // if (response ==
                                                                //     'success') {
                                                                //   Get.back();
                                                                //   Get.snackbar(
                                                                //       'Sucess',
                                                                //       'Profile Updated Successfully');
                                                                // }

                                                                final snackbarSucess =
                                                                    SnackBar(
                                                                        content:
                                                                            Text('Profile updated sucessfully'));
                                                                final snackbarFail =
                                                                    SnackBar(
                                                                        content:
                                                                            Text('Profile updation failed'));

                                                                if (response ==
                                                                    "success") {
                                                                  Navigator.pushNamed(
                                                                          context,
                                                                          '/editProfilePage')
                                                                      .then(
                                                                          (_) {
                                                                    // This block runs when you have returned back to the 1st Page from 2nd.
                                                                    setState(
                                                                        () {
                                                                      // Call setState to refresh the page.
                                                                    });
                                                                  });

                                                                  snackbarSucess;
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackbarSucess);
                                                                  // foodController
                                                                  //     .getAllFood();
                                                                } else {
                                                                  snackbarFail;
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          snackbarSucess);
                                                                }
                                                              }
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              // primary: Colors.orange,
                                                              primary: Color(
                                                                  0xFFFFC61F),
                                                              shape:
                                                                  const StadiumBorder(),
                                                            ),
                                                            child: Text(
                                                              "Update",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      2.2,
                                                                  color: Colors
                                                                      .black),
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
