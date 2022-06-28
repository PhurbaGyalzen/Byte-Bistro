import 'package:byte_bistro/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/http_service.dart';

class AdminFoodDetail extends StatelessWidget {
  AdminFoodDetail({Key? key}) : super(key: key);

  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.only(left: 10),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  onPressed: () => Get.offNamed('/adminScreen'),
                ),
                SizedBox(width: 60),
              ],
            ),

            SizedBox(height: 10),

// food title
            Center(
              child: Text(
                data[1]['name'],
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: Colors.black,
                    wordSpacing: 5),
              ),
            ),
// food image
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
                top: 15,
                left: 10,
                right: 10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: PersistentHtpp.baseUrl + data[4]['image'],
                    placeholder: (context, url) => Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/loading.gif',
                        )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            //food tab

            Container(
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          height: 1.5)),
                  Text(data[2]['price'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: 0.4,
                      )),
                ],
              ),
            ),

            // food description
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
              ),
              child: Text('Detail',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, height: 1.5)),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 20,
                top: 5,
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                height: 220,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(data[3]['description'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          height: 1.5)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
