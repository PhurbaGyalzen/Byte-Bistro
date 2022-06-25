import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/Services/storage_service.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kTextColor,
          ),
          onPressed: () => Get.offAllNamed('/home'),
        ),
        title: Text(' Profile',
            style: TextStyle(
                color: kTextColor,
                fontSize: 18,
                height: 1.5,
                letterSpacing: 1)),
      ),
      backgroundColor: kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileNote(),
                // ProfileUser(),
                ProfileSystem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ProfileNote
class ProfileNote extends StatelessWidget {
  ProfileNote({Key? key}) : super(key: key);
  final LoggedUserInfoController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/userProfilePage');
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 25, top: 10, bottom: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: Offset(0, 3), // changes position of shadow
              color: Color(0xFFB0CCE1).withOpacity(0.32),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: FutureBuilder(
          future: userController.getLoggedUserInfo(),
          builder: (context, snapshot) {
            LoggedUserInfo data = snapshot.data as LoggedUserInfo;
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage( PersistentHtpp.baseUrl
                      + data.profile,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.username,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('+977 9848859531',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 125,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/userProfilePage');
                    },
                    child: Image(
                      height: 20,
                      width: 20,
                      image: AssetImage(
                        'assets/images/next.png',
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

// ProfileUser
class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      margin: EdgeInsets.only(top: 20, bottom: 5),
      child: Column(
        children: const [
          ProfileListTile(
            imageLeading: 'assets/images/shoppingCart.png',
            imageTrailing: 'assets/images/next.png',
            text: 'Cart',
          ),
          ProfileListTile(
            imageLeading: 'assets/images/shoppingCart.png',
            imageTrailing: 'assets/images/next.png',
            text: 'Cart',
          ),
        ],
      ),
    );
  }
}

// ProfileSystem
class ProfileSystem extends StatelessWidget {
  const ProfileSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            ProfileListTile(
              imageLeading: 'assets/images/padlock.png',
              imageTrailing: 'assets/images/next.png',
              text: 'Change Password',
              onClick: () => Get.toNamed('/changePassword'),
            ),
            ProfileListTile(
              imageLeading: 'assets/images/help.png',
              imageTrailing: 'assets/images/next.png',
              text: 'Help',
            ),
            ProfileListTile(
              imageLeading: 'assets/images/accept.png',
              imageTrailing: 'assets/images/next.png',
              text: 'Terms & Conditions',
            ),
            ProfileListTile(
                imageLeading: 'assets/images/logout.png',
                imageTrailing: 'assets/images/next.png',
                text: 'Log out',
                onClick: () async {
                  // final response = await PersistentHtpp.get('food');
                  // print(response.body);
                  // await Storage.setObject('token-val', {'value1': 1});
                  // print('token-val');
                  // print(await Storage.getObject('token-val'));
                  await Storage.remove('token');
                  await PersistentHtpp.storeAndSetHeader(token: '');
                  Get.offAllNamed('/login');
                }),
          ],
        ));
  }
}

// Profile Listtile
class ProfileListTile extends StatelessWidget {
  final String imageLeading;
  final String imageTrailing;
  final String text;
  final void Function()? onClick;

  const ProfileListTile(
      {Key? key,
      required this.imageLeading,
      required this.imageTrailing,
      required this.text,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imageLeading,
        width: 25,
        height: 25,
      ),
      title: Text(text),
      trailing: Opacity(
        opacity: 0.5,
        child: Image(
          height: 20,
          width: 20,
          image: AssetImage(
            imageTrailing,
          ),
        ),
      ),
      onTap: onClick,
    );
  }
}
