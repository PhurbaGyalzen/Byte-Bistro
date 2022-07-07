import 'package:byte_bistro/Screens/notification/notification_detail.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:byte_bistro/utils/utils.dart' as utils;
import 'package:byte_bistro/constants/colors.dart';
import 'package:get/get.dart';

class PendingOrders extends StatefulWidget {
  final Cart cart;
  int orderStatusId = 0;
  final socket;
  // final randomRoom;
  PendingOrders(
      {Key? key,
      required this.socket,
      // required this.randomRoom,
      required this.cart,
      required this.orderStatusId})
      : super(key: key);

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  var btnColor = Color.fromARGB(255, 238, 215, 169);
  var disableColor = Color.fromARGB(255, 203, 203, 203);

  @override
  Widget build(BuildContext context) {
    if (widget.orderStatusId >= CartStatus.Completed.index) {
      // if (false) {
      return Container();
    } else {
      return InkWell(
        onTap: () {
          Get.offAll(NotificationDetail(order: widget.cart));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          margin: EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
                color: Color(0xFFB0CCE1).withOpacity(0.1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                        imageUrl: PersistentHtpp.baseUrl +
                            widget.cart.items[0].foodId.image,
                        placeholder: (context, url) => Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/loading.gif',
                            )),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order #${utils.shortId(widget.cart.id)}"),
                      Text("from ${widget.cart.userId.fullname}"),
                      Text(
                        '${widget.cart.items.length} item' +
                            (widget.cart.items.length > 1 ? 's' : ''),
                        style: TextStyle(
                          fontSize: 12,
                          color: kTextColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.bottomSheet(
                      //   NotificationDetail(order: widget.cart),
                      //   isDismissible: true,
                      //   isScrollControlled: true,
                      //   ignoreSafeArea: false,
                      //   elevation: 20,
                      // )
                      Get.to(NotificationDetail(order: widget.cart));
                    },
                    child: Image(
                      height: 20,
                      width: 20,
                      image: AssetImage(
                        'assets/images/next.png',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.orderStatusId > 0
                          ? null
                          : () {
                              widget.socket.emitWithAck('order_status_change', [
                                {
                                  'room': widget.cart.id,
                                  'orderId': widget.cart.id,
                                  'orderStatus': CartStatus.Preping.index,
                                }
                              ], ack: (data) {
                                String title = 'Status Changed Successfully';
                                if (data['success']) {
                                  setState(() {
                                    widget.orderStatusId =
                                        CartStatus.Preping.index;
                                  });
                                } else {
                                  title = 'Failed to change status';
                                }
                                Get.snackbar(title, data['message']);
                              });
                            },
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size(80, 80), primary: btnColor),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.orderStatusId > 1
                          ? null
                          : () {
                              widget.socket.emitWithAck('order_status_change', [
                                {
                                  'room': widget.cart.id,
                                  'orderId': widget.cart.id,
                                  'orderStatus': CartStatus.Ready.index,
                                }
                              ], ack: (data) {
                                String title = 'Status Changed Successfully';
                                if (data['success']) {
                                  setState(() {
                                    widget.orderStatusId =
                                        CartStatus.Ready.index;
                                  });
                                } else {
                                  title = 'Failed to change status';
                                }
                                Get.snackbar(title, data['message']);
                              });
                            },
                      child: Text(
                        'Ready',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size(100, 100), primary: btnColor),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.orderStatusId > 2
                          ? null
                          : () {
                              Future.delayed(Duration(seconds: 2), () {
                                widget.socket
                                    .emitWithAck('order_status_change', [
                                  {
                                    'room': widget.cart.id,
                                    'orderId': widget.cart.id,
                                    'orderStatus': CartStatus.Completed.index,
                                  }
                                ], ack: (data) {
                                  String title = 'Status Changed Successfully';
                                  if (data['success']) {
                                    setState(() {
                                      widget.orderStatusId =
                                          CartStatus.Completed.index;
                                    });
                                  } else {
                                    title = 'Failed to change status';
                                  }
                                  Get.snackbar(title, data['message']);
                                });
                              });
                            },
                      child: Text(
                        'Complete',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size(70, 100), primary: btnColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
