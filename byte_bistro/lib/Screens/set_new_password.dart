import 'package:byte_bistro/Services/change_password_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({Key? key}) : super(key: key);

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final _formkey = GlobalKey<FormState>();

  bool _isObscureNew = true;

  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
              Form(
                key: _formkey,
                child: Column(
                  children: [
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
                              Map<String, dynamic> response =
                                  await ChangePasswordService.setNewPassword(
                                      newPasswordController.text);

                              if (response["success"]) {
                                Get.snackbar(
                                  "Password Updated",
                                  "Your password has been updated successfully.",
                                  icon: Icon(Icons.lock, color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                Get.offAllNamed('/login');
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
