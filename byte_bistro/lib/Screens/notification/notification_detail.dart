import 'package:byte_bistro/Services/ws_service.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';   

import '../../constants/colors.dart';

class NotificationDetail extends StatefulWidget {
  final Cart order;
  const NotificationDetail({Key? key, required this.order}) : super(key: key);

  @override
  State<NotificationDetail> createState() =>
      _NotificationDetailState(order: order);
}

class _NotificationDetailState extends State<NotificationDetail> {
  final Cart order;

  _NotificationDetailState({required this.order});

  var socket = WebSocketService.socket;

  @override
  void initState() {
    if (socket.disconnected) {
      socket.connect();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalCartPrice = 0;
    // if ()
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10.0),
                child: ListView(children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ORDER DETAILS',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              height: 1.5,
                              color: Colors.orange),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text.rich(TextSpan(
                            text: 'Order ID:  ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.2,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: order.id,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                  height: 1.5,
                                ),
                              ),
                            ])),
                        SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                              text: 'Order Status:  ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: "Pending..",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.2,
                                    height: 1.5,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                              text: 'Order Date:  ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: Jiffy(order.createdAt).yMMMMEEEEdjm,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.2,
                                    height: 1.5,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                              text: 'Order Total: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(
                                  text: totalCartPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.2,
                                    height: 1.5,
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Order Items: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.2,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                                color: Color(0xFFB0CCE1).withOpacity(0.32),
                              ),
                            ],
                          ),
                          height: 200,
                          child: ListView.builder(
                            itemCount: order.items.length,
                            itemBuilder: (context, index) {
                              totalCartPrice +=
                                  order.items[index].foodId.price *
                                      order.items[index].qty;
                              return Container(
                                decoration: BoxDecoration(
                                  color: kTextLightColor.withOpacity(0.2),
                                ),
                                child: ListTile(
                                  style: ListTileStyle.list,
                                  title: Text(
                                    order.items[index].foodId.name,
                                    style: TextStyle(height: 1.5),
                                  ),
                                  subtitle: Text(
                                    '${order.items[index].qty} x ${order.items[index].foodId.price} = ${order.items[index].foodId.price * order.items[index].qty}',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Back',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
