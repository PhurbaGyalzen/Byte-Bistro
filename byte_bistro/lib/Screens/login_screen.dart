import 'package:byte_bistro/Screens/dummy.dart';
import 'package:byte_bistro/Screens/google_signin_api.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/Services/storage_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../Services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final user = GoogleSignInApi.logout();

  bool _isObscure = true;

  // editing controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signIn() async {
    final user = await GoogleSignInApi.login();
    print(user);

    if (user == null) {
      print("user is null");
      Get.snackbar(
        "Sign in with googleS",
        "Please try again",
        icon: Icon(Icons.person_rounded, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        animationDuration: Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;

      var response = await AuthService.googleAuth(
          user.displayName.toString(),
          user.id.toString(),
          user.displayName.toString(),
          user.email.toString());
      print(response);
      if (response != null) {
        await PersistentHtpp.storeAndSetHeader(token: response.token);
        prefs.setString("token", response.token);
        Get.offNamed('/home');
      } else {
        Get.snackbar(
          "Couldn't get response",
          "Please try again",
          icon: Icon(Icons.person_rounded, color: Colors.white),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          animationDuration: Duration(seconds: 1),
          dismissDirection: DismissDirection.horizontal,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // const SizedBox(
              //   height: 10,
              // ),
              Image.asset(
                'assets/images/login.png',
              ),
              Container(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      ///username start
                      TextFormField(
                        key: const ValueKey('username'),
                        controller: usernameController,
                        validator: RequiredValidator(errorText: 'required*'),
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
                              color: kTextColor.withOpacity(0.2),
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
                          prefixIcon: const Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
                        ),
                      ),

                      ///username end
                      const SizedBox(
                        height: 15,
                      ),

                      ///password start
                      TextFormField(
                        key: const ValueKey('password'),
                        controller: passwordController,
                        validator: RequiredValidator(errorText: 'required*'),

                        // obscureText: true,
                        obscureText: _isObscure,

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
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            key: ValueKey('show_hide'),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(
                              _isObscure
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

                      ///password end
                      const SizedBox(
                        height: 15,
                      ),

                      //forgot password
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/reset_password',
                              arguments: <String, String>{
                                'email': usernameController.text.trim()
                              });
                        },
                        child: Text(
                          "Forgot your password?",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      //forgot password end

                      const SizedBox(
                        height: 40,
                      ),
                      //login button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          key: const ValueKey('loginButton'),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              // print(usernameController.text);
                              // print(passwordController.text);
                              final Future<SharedPreferences> _prefs =
                                  SharedPreferences.getInstance();
                              final SharedPreferences prefs = await _prefs;

                              var response = await AuthService.login(
                                usernameController.text.trim(),
                                passwordController.text,
                              );

                              if (response != null) {
                                await PersistentHtpp.storeAndSetHeader(
                                    token: response.token);
                                if (response.isAdmin == true) {
                                  prefs.setString("token", response.token);
                                  Get.offNamed('/adminScreen');
                                } else if (response.isAdmin == false) {
                                  prefs.setString("token", response.token);
                                  // Get.offNamed('/onBoardingScreen');
                                  Get.offNamed('/home');
                                }
                              } else {
                                Get.snackbar(
                                  "Invalid Creditentials",
                                  "Please try again",
                                  icon: Icon(Icons.person_rounded,
                                      color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                // print("cannot login");
                              }
                            }
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.orange,
                            primary: kPrimary,
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ),
                      //login button end

                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFDD4839),
                          shape: const StadiumBorder(),
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                        ),
                        onPressed: signIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/google.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text('Login with Google'),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      ///sign up
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/signup');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Don't have an account?"),
                            Text(
                              " Sign Up",
                              style: TextStyle(
                                // color: Colors.orange,
                                color: kTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      //sign up end
                      // const SizedBox(
                      //   height: 50,
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
