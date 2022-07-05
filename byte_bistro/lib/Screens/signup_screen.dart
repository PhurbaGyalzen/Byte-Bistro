import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../Services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure2 = true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/signUp.png',
                height: 200,
                width: 500,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 50,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      ///name field start
                      TextFormField(
                        controller: fullnameController,
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
                          border: InputBorder.none,
                          hintText: "Name",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          prefixIcon: const Icon(Icons.person),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
                        ),
                      ),
                      //name end

                      const SizedBox(
                        height: 15,
                      ),

                      //userName start
                      TextFormField(
                        controller: usernameController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: '*required'),
                          MinLengthValidator(5, errorText: '*min length is 5'),
                        ]),
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
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          prefixIcon: const Icon(Icons.person),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
                        ),
                      ),
                      //username end
                      const SizedBox(
                        height: 15,
                      ),

                      //email start
                      TextFormField(
                        controller: emailController,
                        validator: MultiValidator([
                          EmailValidator(
                            errorText: 'enter a valid email address',
                          ),
                          RequiredValidator(
                            errorText: '*required',
                          ),
                          MinLengthValidator(
                            6,
                            errorText: 'minimum length is 6',
                          ),
                        ]),
                        keyboardType: TextInputType.emailAddress,
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
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          prefixIcon: const Icon(Icons.email),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
                        ),
                      ),
                      //email end

                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: '*required',
                          ),
                          MinLengthValidator(
                            6,
                            errorText: 'minimum length is 6',
                          ),
                          MaxLengthValidator(
                            20,
                            errorText: 'maximum length is 20',
                          ),
                        ]),
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
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
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
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: confirmpasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*required";
                          }
                          if (value != passwordController.text) {
                            return "password does not match";
                          }
                          return null;
                        },
                        obscureText: _isObscure2,
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
                          border: InputBorder.none,
                          hintText: "Confirm Password",
                          hintStyle: Theme.of(context).textTheme.bodyText2,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            },
                            icon: Icon(
                              _isObscure2
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
                        ),
                      ),
                      //passwprd end

                      const SizedBox(
                        height: 35,
                      ),

                      //sign button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              var response = await AuthService.signup(
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                                emailController.text.trim(),
                                fullnameController.text.trim(),
                              );
                              print(usernameController.text.trim());
                              print(response);

                              if (response != null) {
                                Get.snackbar(
                                  "User Registered Successfully",
                                  "Please Login",
                                  icon: Icon(Icons.person_rounded,
                                      color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                Navigator.popAndPushNamed(context, '/login');
                              } else {
                                Get.snackbar(
                                  "User failed to be registered",
                                  "Please try again/ Can be duplicate username or email entry",
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
                            "Sign Up",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: kPrimary,
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ),
                      //sign button end
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/login');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              " Login",
                              style: TextStyle(
                                // color: Colors.orange,
                                color: kTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
