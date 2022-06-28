import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserFoodDetail extends StatelessWidget {
  UserFoodDetail({Key? key}) : super(key: key);

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
                  onPressed: () => Get.offNamed('/home'),
                ),
                SizedBox(width: 60),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image(
                          image: AssetImage('assets/images/love_not_fill.png'),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image(
                          image: AssetImage('assets/images/flatCart.png'),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                )
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
                    imageUrl: PersistentHtpp.baseUrl +
                        data[4]['image'],
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

// item add remove button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), color: kPrimary),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    iconSize: 18,
                    onPressed: () {},
                  ),
                ),
                Text(
                  '2',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), color: kPrimary),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 18,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 25,
            ),

            //food tab
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: 2.0, color: kTextLightColor.withOpacity(0.5)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Size',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              height: 1.5)),
                      Text('Medium',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: 0.4)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: 2.0, color: kTextLightColor.withOpacity(0.5)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Weight',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              height: 1.5)),
                      Text('400gm',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: 0.4)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: 2.0, color: kTextLightColor.withOpacity(0.5)),
                    ),
                  ),
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
              ],
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
                left: 20,
                bottom: 20,
                top: 5,
              ),
              child: SizedBox(
                height: 100,
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

            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 5,
                bottom: 5,
                right: 20,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Add to cart',
                  style: Theme.of(context).textTheme.headline1,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  primary: kPrimary,
                  textStyle: TextStyle(
                    color: kTextLightColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
