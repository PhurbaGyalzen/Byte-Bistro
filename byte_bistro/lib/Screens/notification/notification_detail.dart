import 'dart:ffi';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/Services/ws_service.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:duration_picker/duration_picker.dart';


import '../../constants/colors.dart';

class NotificationDetail extends StatefulWidget {
  final Cart order;
  const NotificationDetail({Key? key, required this.order}) : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  final CartController cartController = Get.find();
  late Duration _duration;
  var socket = WebSocketService.socket;

  @override
  void initState() {
    WebSocketService.authenticate();
    _duration = Duration(hours: 0, minutes: widget.order.duration);
    super.initState();
  }

  @override
  void dispose() {
    // disconnect websocket?
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalCartPrice =
        widget.order.items.fold(0, (t, e) => t + (e.foodId.price * e.qty));

    // int vat = totalCartPrice*(13/100).toInt();
    // if ()

    double grandtotalCartPrice =
        totalCartPrice.toDouble() + (totalCartPrice.toDouble() * 0.13);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Order Details',
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/adminOrders'),
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text.rich(TextSpan(
                        text: 'Order ID: ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: widget.order.id,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.2,
                              height: 1.5,
                            ),
                          ),
                        ])),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                          text: 'Order Status: ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: CartStatus.values[widget.order.status].name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.2,
                                height: 1.5,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                          text: 'Order Date: ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: Jiffy(widget.order.createdAt).yMMMMEEEEdjm,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.2,
                                height: 1.5,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                          text: 'Grand Total(VAT@13%): ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: "Rs ${grandtotalCartPrice.toString()}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
                            offset: Offset(0, 3), // changes position of shadow
                            color: Color(0xFFB0CCE1).withOpacity(0.32),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.order.items.length,
                        itemBuilder: (context, index) {
                          totalCartPrice +=
                              widget.order.items[index].foodId.price *
                                  widget.order.items[index].qty;

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                  imageUrl: PersistentHtpp.baseUrl +
                                      widget.order.items[index].foodId.image,
                                  placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/loading.gif',
                                      )),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              style: ListTileStyle.list,
                              title: Text(
                                widget.order.items[index].foodId.name,
                                style: TextStyle(height: 1.5),
                              ),
                              subtitle: Text(
                                'Rs ${widget.order.items[index].foodId.price} x ${widget.order.items[index].qty}= Rs ${widget.order.items[index].foodId.price * widget.order.items[index].qty}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                   
                    ElevatedButton.icon(
                      icon: Icon(
                        
                        Icons.timelapse_outlined,
                        size: 24.0,

                      ),
                      label: Text('Set Duration', style: TextStyle(color:Colors.black),),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      onPressed: () async {
                        Duration? resultingDuration = await showDurationPicker(
                          context: context,
                          initialTime: _duration,
                        );
                        if (resultingDuration == null) {
                          return;
                        }
                        cartController.updateDuration(
                            widget.order.id, resultingDuration.inMinutes);
                        socket.emitWithAck('order_status_change', [
                          {
                            'room': widget.order.id,
                            'orderId': widget.order.id,
                            'orderStatus': CartStatus.Preping.index,
                          }
                        ], ack: (data) {
                          String title = 'Status Changed Successfully';
                          if (data['success']) {
                            // setState(() {
                            //   widget.orderStatusId =
                            //       CartStatus.Preping.index;
                            // });
                          } else {
                            title = 'Failed to change status';
                          }
                          Get.snackbar(title, data['message']);
                        });
                        setState(() {
                          _duration = resultingDuration;
                        });
                      },
                      
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
