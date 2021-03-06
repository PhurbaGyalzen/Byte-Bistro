// import 'package:byte_bistro/Screens/notification/notification_data.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/notification_controller.dart';
import 'package:byte_bistro/models/notificationO.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/notification.dart';

class NotificationOffer extends StatefulWidget {
  const NotificationOffer({Key? key}) : super(key: key);
  @override
  _NotificationOfferState createState() => _NotificationOfferState();
}

class _NotificationOfferState extends State<NotificationOffer> {
  NotificationController notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: notificationController.getOfferNotification(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<NotificationO> notificationData =
                  snapshot.data as List<NotificationO>;
              // print(notificationData);
              return Container(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: notificationData.length,
                  itemBuilder: ((context, index) => Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 15,
                          bottom: 15,
                          right: 20,
                        ),
                        margin: EdgeInsets.only(
                            top: 20, bottom: 5, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                              color: Color(0xFFB0CCE1).withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notificationData[index].title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kTextColor,
                                height: 1.5,
                                letterSpacing: 0.09,
                              ),
                            ),
                            Text(
                              notificationData[index].message,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 20,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 190,
                                  width: MediaQuery.of(context).size.width,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: PersistentHtpp.baseUrl +
                                        notificationData[index].image,
                                    placeholder: (context, url) => Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/loading.gif',
                                        )),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       'Price ${notificationData[index]['totalPrice']}'
                            //           .toString(),
                            //       style: TextStyle(
                            //           color: kTextColor,
                            //           fontWeight: FontWeight.w200),
                            //     ),
                            //     Text(
                            //       '${notificationData[index]['time']} hrs ago',
                            //       style: TextStyle(color: kTextLightColor),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      )),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
