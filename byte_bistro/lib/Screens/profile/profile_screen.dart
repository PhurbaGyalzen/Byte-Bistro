import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/Services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: kTextColor,
        //   ),
        //   onPressed: () => Get.toNamed('/home'),
        // ),
        title: Text(
          'My Profile',
          style: TextStyle(color: kTextColor, fontSize: 16),
        ),
      ),
      backgroundColor: kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
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
              children: const [
                ProfileNote(),
                ProfileUser(),
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
  const ProfileNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/images/user.jpg',
            
              
            ),
          ),
          // SizedBox(
          //   width: 40,
          // ),
          Column(
            children: const [
              Text('User 1',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  )),
              Text('+977 9848859531',
                  style: TextStyle(fontWeight: FontWeight.w300)),
            ],
          ),
          // SizedBox(
          //   width: 125,
          // ),
          Opacity(
            opacity: 0.5,
            child: GestureDetector(
              onTap: () => Get.toNamed('/editProfilePage'),
              child: Image(
                height: 20,
                width: 20,
                image: AssetImage(
                  'assets/images/next.png',
                ),
              ),
            ),
          )
        ],
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
            imageLeading: 'assets/images/credit-card.png',
            imageTrailing: 'assets/images/next.png',
            text: 'Payment Methods',
          ),
          ProfileListTile(
            imageLeading: 'assets/images/like.png',
            imageTrailing: 'assets/images/next.png',
            text: 'Favourites',
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
              imageLeading: 'assets/images/notification.png',
              imageTrailing: 'assets/images/next.png',
              text: 'Notification',
            ),
            ProfileListTile(
              imageLeading: 'assets/images/settings.png',
              imageTrailing: 'assets/images/next.png',
              text: 'Settings',
            ),
            ProfileListTile(
              imageLeading: 'assets/images/add-user.png',
              imageTrailing: 'assets/images/next.png',
              text: 'Invite Friends',
            ),
            ProfileListTile(
              imageLeading: 'assets/images/help.png',
              imageTrailing: 'assets/images/next.png',
              text: 'Help',
            ),
            ProfileListTile(
                imageLeading: 'assets/images/logout.png',
                imageTrailing: 'assets/images/next.png',
                text: 'Log out',
                onClick: () async {
                  await Storage.remove('token');
                  await PersistentHtpp.storeAndSetHeader(token: '');
                  // Get.toNamed('/login');
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
