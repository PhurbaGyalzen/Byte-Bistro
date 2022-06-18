import 'dart:convert';

import 'package:byte_bistro/Screens/notification/notificationTab1.dart';
import 'package:byte_bistro/Screens/notification/notificationTab2.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/favourite_controller.dart';
import 'package:byte_bistro/controller/notification_controller.dart';
import 'package:byte_bistro/models/favourite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:byte_bistro/constants/colors.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  FavouriteController favouriteController = Get.put(FavouriteController());
  @override
  Widget build(BuildContext context) {
  
    List<Favourite> favouriteData = favouriteController.getUserFavourites("627fbfa1d464ffbeb80b985b");
    // print(response);
    return Scaffold(
      
      body: Container(
        child: Text("Favourite Page"),
        
        ),);
  }
}
