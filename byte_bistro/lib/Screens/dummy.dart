import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DummyLogin extends StatelessWidget {
  final GoogleSignInAccount user;

  DummyLogin({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Logged In"),
          centerTitle: true,
        ),
        body: Container(
            alignment: Alignment.center,
            color: Colors.blueGrey.shade900,
            child: Column(
              children: [
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 32,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.photoUrl!),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('Email: ' + user.email),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),
      );
}
