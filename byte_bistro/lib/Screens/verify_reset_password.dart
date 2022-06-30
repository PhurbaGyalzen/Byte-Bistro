import 'package:byte_bistro/Services/auth_service.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyResetPassword extends StatefulWidget {
  @override
  _VerifyResetPasswordState createState() => _VerifyResetPasswordState();
}

class _VerifyResetPasswordState extends State<VerifyResetPassword> {
  TextEditingController otpController = TextEditingController();
  var args = Get.arguments;
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
                Text(
                  "Enter the ${args['otpLength']} digit OTP sent to ${args['email']}. The OTP will expire in T-${args['otpTimeout']} minutes.",
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFF2F2F2),
                    shape: StadiumBorder(),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "OTP Code",
                        hintStyle: TextStyle(
                          color: Color(0xFFB6B7B7),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 40,
                        )),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      String otp = otpController.text.trim();
                      Map<String, dynamic> data =
                          await AuthService.verifyResetPassword(
                              Get.arguments['email'], otp);
                      if (data['token'] != null) {
                        PersistentHtpp.storeAndSetHeader(token: data['token']);
                        Get.snackbar(
                          "OTP correct",
                          "",
                          icon: Icon(Icons.lock, color: Colors.white),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          animationDuration: Duration(seconds: 1),
                          dismissDirection: DismissDirection.horizontal,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Get.toNamed('/set_new_password');
                      } else {
                        print(data);
                        Get.snackbar(
                          "OTP Error",
                          data['message'],
                          icon: Icon(Icons.lock, color: Colors.white),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          animationDuration: Duration(seconds: 1),
                          dismissDirection: DismissDirection.horizontal,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Verify"),
                  ),
                ),
                const Spacer(
                  flex: 9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
