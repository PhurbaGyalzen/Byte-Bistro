import 'package:byte_bistro/Screens/home_page.dart';
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

  bool _isObscure = true;

  // editing controller
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset('assets/images/login_image.jpg'),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      ///username start
                      TextFormField(
                        controller: usernameController,
                        validator: RequiredValidator(errorText: '*required'),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF2F2F2),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF2F2F2),
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
                          hintStyle: const TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
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
                        controller: passwordController,
                        validator: RequiredValidator(errorText: '*required'),

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
                            borderSide: const BorderSide(
                              color: Color(0xFFF2F2F2),
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
                          hintStyle: const TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
                        ),
                      ),

                      ///password end
                      const SizedBox(
                        height: 15,
                      ),

                      //forgot password
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotPassword');
                        },
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
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
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              // print(usernameController.text);
                              // print(passwordController.text);
                              final Future<SharedPreferences> _prefs =
                                  SharedPreferences.getInstance();
                              final SharedPreferences prefs = await _prefs;

                              var response = await AuthService.login(
                                usernameController.text,
                                passwordController.text,
                              );

                              if (response != null) {
                                prefs.setString("token", response.token);
                                Navigator.pushNamed(context, '/home');
                              } else {
                                print("cannot login");
                              }
                              ;
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.orange,
                            primary: Colors.blue,
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ),
                      //login button end

                      const SizedBox(
                        height: 10,
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
                                color: Colors.blue,
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
