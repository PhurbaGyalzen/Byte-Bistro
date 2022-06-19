import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:get/get.dart';

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
  late final TextEditingController bioController = TextEditingController(text: widget.bio);
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                  height: 20,
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/userProfilePage');
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
                    Expanded(child: SizedBox()),
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