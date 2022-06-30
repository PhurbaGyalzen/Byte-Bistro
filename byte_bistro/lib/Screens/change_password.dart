import 'package:byte_bistro/Services/change_password_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formkey = GlobalKey<FormState>();

  bool _isObscureNew = true;
  bool _isObscureOld = true;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Change Password',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // onPressed: () => Get.offNamed('/profileScreen'),
          onPressed: () => Get.back(),
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            bottom: 10,
            left: 40,
            right: 40,
          ),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/lock.png",
                  height: 200,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                child: Text(
                  "Create new password",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  // top: 16,
                  bottom: 20,
                ),
                child: Text(
                  "Your new password must be different from previously used password.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              // Expanded(child: SizedBox()),

              Form(
                key: _formkey,
                child: Column(
                  children: [
                    ///old password start
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        controller: oldPasswordController,
                        validator: RequiredValidator(errorText: 'required*'),

                        // obscureText: true,
                        obscureText: _isObscureOld,

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF2F2F2),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kTextLightColor.withOpacity(0.2),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF2F2F2),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF2F2F2),
                          hintText: "Old Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscureOld = !_isObscureOld;
                              });
                            },
                            icon: Icon(
                              _isObscureOld
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
                          border: InputBorder.none,
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),

                    ///new password start
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        controller: newPasswordController,
                        validator: RequiredValidator(errorText: 'required*'),

                        // obscureText: true,
                        obscureText: _isObscureNew,

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF2F2F2),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kTextLightColor.withOpacity(0.2),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF2F2F2),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF2F2F2),
                          hintText: "New Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscureNew = !_isObscureNew;
                              });
                            },
                            icon: Icon(
                              _isObscureNew
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
                          border: InputBorder.none,
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    //login button
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              Map<String, dynamic> data = {
                                "oldPassword": oldPasswordController.text,
                                "newPassword": newPasswordController.text,
                              };

                              String response = await ChangePasswordService
                                  .changePasswordService(data);

                              print("response ${response}");
                              if (response == "success") {
                                oldPasswordController.clear();
                                newPasswordController.clear();

                                Get.snackbar(
                                  "Password Changed",
                                  "Your password has been changed.",
                                  icon: Icon(Icons.lock, color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              } else if (response == "!=oldPassword") {
                                Get.snackbar(
                                  "Password doesn't match",
                                  "Please try again",
                                  icon: Icon(Icons.lock, color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              } else if (response == "old==new") {
                                Get.snackbar(
                                  "Your new password shouldn't match old password",
                                  "Please try again",
                                  icon: Icon(Icons.lock, color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            }
                          },
                          child: Text(
                            "Change Password",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.orange,
                            primary: kPrimary,
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
