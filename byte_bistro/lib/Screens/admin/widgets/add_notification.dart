import 'dart:io';

import 'package:byte_bistro/Services/auth_service.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNotification extends StatefulWidget {
  final String bio;
  final String fullName;
  final String email;
  final String address;
  const AddNotification(
      {Key? key,
      this.bio = '',
      this.fullName = '',
      this.address = '',
      this.email = ''})
      : super(key: key);

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
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
  var imageName = "";
  late File? pickedImage;

  Future<void> pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      var res = await AuthService.updateProfile(tempImage);
      setState(() {
        pickedImage = tempImage;
        imageName = tempImage.path.split("/").last;
      });
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Notification',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
          // onPressed: () => Get.offNamed('/userProfilePage'),
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
                    child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/300'),
                      radius: 70,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Color(0xFFFFC61F),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            Get.bottomSheet(
                              SingleChildScrollView(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  child: Container(
                                    color: Colors.black,
                                    height: 250,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          const Text(
                                            "Upload Offer Image From",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  kPrimary, // Background color
                                            ),
                                            onPressed: () {
                                              pickImage(ImageSource.camera);
                                            },
                                            icon: const Icon(Icons.camera),
                                            label: const Text("CAMERA"),
                                          ),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  kPrimary, // Background color
                                            ),
                                            onPressed: () {
                                              pickImage(ImageSource.gallery);
                                            },
                                            icon: const Icon(Icons.image),
                                            label: const Text("GALLERY"),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  kPrimary, // Background color
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.close),
                                            label: const Text("CANCEL"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  validator: RequiredValidator(errorText: '*required'),
                  controller: fullnameController,
                  minLines: 2,
                  maxLines: 2,
                  // initialValue:
                  //     data.fullname,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Title',
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
                      RequiredValidator(
                        errorText: '*required',
                      ),
                    ],
                  ),
                  controller: emailController,
                  minLines: 8,
                  maxLines: 10,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Description',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                  ),
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
                          };
                          // String response =
                          //     await LoggedUserInfoController.updateProfileInfo(
                          //         data);

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

                          // if (response == "success") {
                          //   Get.toNamed("/adminProfile");

                          //   // snackbarSucess;
                          //   // ScaffoldMessenger.of(context)
                          //   //     .showSnackBar(snackbarSucess);
                          //   // foodController
                          //   //     .getAllFood();
                          // }
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
                        "Add Notification",
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