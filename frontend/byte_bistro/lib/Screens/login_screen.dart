import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    ///username start
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFF2F2F2),
                        shape: StadiumBorder(),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: "Your username",
                          hintStyle: TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
                        ),
                      ),
                    ),

                    ///username end
                    const SizedBox(
                      height: 15,
                    ),

                    ///password start
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFF2F2F2),
                        shape: StadiumBorder(),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xFFB6B7B7),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(
                            20.0,
                            15.0,
                            20.0,
                            15.0,
                          ),
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text("Login"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
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
                        Navigator.popAndPushNamed(context, '/signup');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Don't have an account?"),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    //sign up end
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
