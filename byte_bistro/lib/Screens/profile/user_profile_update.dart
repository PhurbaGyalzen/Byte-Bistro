import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class UserProfileUpdateForm extends StatefulWidget {
  final String bio;
  final String fullName;
  final String email;
  final String address;
  const UserProfileUpdateForm(
      {Key? key,
      this.bio = '',
      this.fullName = '',
      this.address = '',
      this.email = ''})
      : super(key: key);

  @override
  State<UserProfileUpdateForm> createState() => _UserProfileUpdateFormState();
}

class _UserProfileUpdateFormState extends State<UserProfileUpdateForm> {
  // editing controller

  late TextEditingController fullnameController =
      TextEditingController(text: widget.fullName);
  late final TextEditingController emailController =
      TextEditingController(text: widget.email);
  // final TextEditingController phoneController = TextEditingController(text: phone1);
  late final TextEditingController addressController =
      TextEditingController(text: widget.address);
  late final TextEditingController bioController =
      TextEditingController(text: widget.bio);
  final formkey = GlobalKey<FormState>();
  final LoggedUserInfoController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/userProfilePage'),
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 26, top: 50, right: 26),
          child: Form(
            key: formkey,
            child: Column(
              children: [
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
                                  color: Color(0xFFFFC61F),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/300'),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  validator: RequiredValidator(errorText: '*required'),
                  controller: fullnameController,
                  // initialValue:
                  //     data.fullname,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Fullname',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: MultiValidator(
                    [
                      EmailValidator(
                        errorText: 'enter a valid email address',
                      ),
                      RequiredValidator(
                        errorText: '*required',
                      ),
                    ],
                  ),
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'E-mail',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: RequiredValidator(errorText: '*required'),
                  controller: addressController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Address',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: RequiredValidator(errorText: '*required'),
                  controller: bioController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Bio",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            "fullname": fullnameController.text,
                            "email": emailController.text,
                            // "phones":
                            //     [phoneController
                            //         .text],
                            "bio": bioController.text,
                            "address": addressController.text,
                          };
                          String response =
                              await LoggedUserInfoController.updateProfileInfo(
                                  data);

                          // if (response ==
                          //     'success') {
                          //   Get.back();
                          //   Get.snackbar(
                          //       'Sucess',
                          //       'Profile Updated Successfully');
                          // }

                          // final snackbarSucess = SnackBar(
                          //     content: Text('Profile updated sucessfully'));
                          // final snackbarFail = SnackBar(
                          //     content: Text('Profile updation failed'));

                          if (response == "success") {
                            Get.toNamed("/adminProfile");

                            // snackbarSucess;
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackbarSucess);
                            // foodController
                            //     .getAllFood();
                          }
                          //  else {
                          //   snackbarFail;
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(snackbarSucess);
                          // }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.orange,
                        primary: Color(0xFFFFC61F),
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
  }
}
