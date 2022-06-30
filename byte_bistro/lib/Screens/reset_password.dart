import 'package:byte_bistro/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController =
      TextEditingController(text: Get.arguments['email']);

  @override
  void dispose() {
    emailController.dispose();
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
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
                const Text(
                  "Please enter your email to receive a One Time Password(OTP) so that we can verify you.",
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
                    controller: emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
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
                      String email = emailController.text.trim();
                      Map<String, dynamic> data =
                          await AuthService.resetPassword(email);
                      if (data['success']) {
                        // get snackbar
                        Get.toNamed('/verify_reset_password',
                            arguments: <String, dynamic>{
                              'email': email,
                              'otpTimeout': data['otpTimeoutMins'],
                              'otpLength': data['otpLength']
                            });
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
