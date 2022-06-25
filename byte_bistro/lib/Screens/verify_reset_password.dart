import 'package:byte_bistro/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyResetPassword extends StatefulWidget {
  @override
  _VerifyResetPasswordState createState() => _VerifyResetPasswordState();
}

class _VerifyResetPasswordState extends State<VerifyResetPassword> {
  TextEditingController otpController = TextEditingController();

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
                          Navigator.pushNamed(context, '/login');
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
                  "Enter the ${Get.arguments['optLength']} digit OTP sent to ${Get.arguments['email']}. The OTP will expire in T-${Get.arguments['otpTimeout']} minutes.",
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
                      String email = otpController.text.trim();
                      print('email is $email');
                      Map<String, dynamic> data =
                          await AuthService.resetPassword(email);
                      if (data['success']) {
                        // get snackbar
                        Get.toNamed('/verify_reset_password');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Send"),
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
