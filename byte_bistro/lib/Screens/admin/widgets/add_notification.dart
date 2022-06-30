import 'dart:io';

import 'package:byte_bistro/Services/auth_service.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/notification_controller.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNotification extends StatefulWidget {
  final String title;
  final String description;

  const AddNotification({Key? key, this.title = '', this.description = ''})
      : super(key: key);

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  // editing controller

  late TextEditingController titleController =
      TextEditingController(text: widget.title);
  late final TextEditingController descriptionController =
      TextEditingController(text: widget.description);
  // final TextEditingController phoneController = TextEditingController(text: phone1);
  final formkey = GlobalKey<FormState>();
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Offer',
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
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  validator: RequiredValidator(errorText: '*required'),
                  controller: titleController,
                  minLines: 2,
                  maxLines: 2,
                  // initialValue:
                  //     data.title,
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
                  controller: descriptionController,
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
                            "title": titleController.text,
                            "message": descriptionController.text,
                          };

                          String response = await notificationController
                              .addOfferNotification(data);

                          if (response == 'success') {
                            Get.back();
                            Get.snackbar('Sucess', 'Added Offer successfully');
                          }

                          final snackbarSucess = SnackBar(
                              content: Text('Offer added successfully'));
                          final snackbarFail =
                              SnackBar(content: Text('Failed to add Offer'));

                          if (response == "success") {
                            Get.toNamed("/adminProfile");

                            // snackbarSucess;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbarSucess);
                            // foodController
                            //     .getAllFood();
                          } else {
                            snackbarFail;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbarFail);
                          }
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
