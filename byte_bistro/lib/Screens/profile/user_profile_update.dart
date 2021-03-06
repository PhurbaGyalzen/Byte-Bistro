import 'dart:io';

import 'package:byte_bistro/Services/auth_service.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  var imageName = "";
  late File? pickedImage;

  Future<void> pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      var res = await AuthService.updateProfile(tempImage);
      setState((){
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
          padding: EdgeInsets.only(left: 26, top: 40, right: 26),
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
                            ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(150)),

                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                              imageUrl: PersistentHtpp.baseUrl + data!.profile,
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
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  const Text(
                                                    "Upload Profile Image from:",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          kPrimary, // Background color
                                                    ),
                                                    onPressed: () {
                                                      pickImage(
                                                          ImageSource.camera);
                                                    },
                                                    icon: const Icon(
                                                        Icons.camera),
                                                    label: const Text("CAMERA"),
                                                  ),
                                                  ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          kPrimary, // Background color
                                                    ),
                                                    onPressed: () {
                                                      pickImage(
                                                          ImageSource.gallery);
                                                    },
                                                    icon:
                                                        const Icon(Icons.image),
                                                    label:
                                                        const Text("GALLERY"),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          kPrimary, // Background color
                                                    ),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
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
                        );
                      } else {
                        return CircleAvatar(
                          radius: 50,
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
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                      
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

                            

                            if (response == "success") {
                              Get.toNamed("/adminProfile");

                             
                            }
                            
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
