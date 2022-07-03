import 'package:byte_bistro/Services/ws_service.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/models/cart.dart';
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

  @override
  void initState() {
    super.initState();
    _duration = Duration(hours: 0, minutes: widget.order.duration);
  }

  @override
  Widget build(BuildContext context) {
    int totalCartPrice =
        widget.order.items.fold(0, (t, e) => t + (e.foodId.price * e.qty));
    ;
    // if ()
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
                child: ListView(children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
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
                                text: widget.order.id,
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
                                  text: CartStatus
                                      .values[widget.order.status].name,
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
                                  text: Jiffy(widget.order.createdAt)
                                      .yMMMMEEEEdjm,
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
                            itemCount: widget.order.items.length,
                            itemBuilder: (context, index) {
                              totalCartPrice +=
                                  widget.order.items[index].foodId.price *
                                      widget.order.items[index].qty;
                                
                              return Container(
                                decoration: BoxDecoration(
                                  color: kTextLightColor.withOpacity(0.2),
                                ),
                                child: ListTile(
                                  style: ListTileStyle.list,
                                  title: Text(
                                    widget.order.items[index].foodId.name,
                                    style: TextStyle(height: 1.5),
                                  ),
                                  subtitle: Text(
                                    '${widget.order.items[index].qty} x ${widget.order.items[index].foodId.price} = ${widget.order.items[index].foodId.price * widget.order.items[index].qty}',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () async {
                            Duration? resultingDuration =
                                await showDurationPicker(
                              context: context,
                              initialTime: _duration,
                            );
                            if (resultingDuration == null) {
                              return;
                            }
                            cartController.updateDuration(
                                widget.order.id, resultingDuration.inMinutes);
                            setState(() {
                              _duration = resultingDuration;
                            });
                          },
                          child: Text(
                            'Set Food Prep Duration',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
