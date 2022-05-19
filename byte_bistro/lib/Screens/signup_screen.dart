import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.only(left: 40),
              //   width: MediaQuery.of(context).size.width,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.pushNamed(context, '/login');
              //         },
              //         child: const Icon(
              //           Icons.arrow_back_ios_rounded,
              //           color: Colors.blue,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              Image.asset('assets/images/sign_u2.png'),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      ///name field start
                      TextFormField(
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
                          hintStyle: const TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
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
                          hintText: "Username",
                          hintStyle: const TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
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
                        validator: MultiValidator([
                          EmailValidator(
                            errorText: 'enter a valid email address',
                          ),
                          RequiredValidator(
                            errorText: '*required',
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
                          hintStyle: const TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
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
                      //password start
                      TextFormField(
                        validator: RequiredValidator(errorText: '*required'),
                        obscureText: true,
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
                          hintStyle: const TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
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
                      //passwprd end

                      const SizedBox(
                        height: 15,
                      ),

                      //sign button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.popAndPushNamed(context, '/login');
                            }
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
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
                          children: const [
                            Text("Already have an account?"),
                            Text(
                              " Login",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
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
