import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class AdminProfileUpdateForm extends StatefulWidget {
  final String bio;
  final String fullName;
  final String email;
  final String address;
  const AdminProfileUpdateForm(
      {Key? key,
      this.bio = '',
      this.fullName = '',
      this.address = '',
      this.email = ''})
      : super(key: key);

  @override
  State<AdminProfileUpdateForm> createState() => _AdminProfileUpdateFormState();
}

class _AdminProfileUpdateFormState extends State<AdminProfileUpdateForm> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/adminProfile'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/buffMomo.jpg'),
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                    height: 30,
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
                    height: 30,
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
                    height: 30,
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
                    height: 30,
                  ),
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
                ],
              )),
        ),
      ),
    );
  }
}
