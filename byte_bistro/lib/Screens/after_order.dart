import 'package:byte_bistro/Services/ws_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:byte_bistro/utils/utils.dart' as utils;
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class AfterOrderScreen extends StatefulWidget {
  const AfterOrderScreen({Key? key}) : super(key: key);

  @override
  _AfterOrderScreenState createState() => _AfterOrderScreenState();
}

class _AfterOrderScreenState extends State<AfterOrderScreen> {
  CartController cartController = Get.find();

  int? orderStatus;
  int? orderDurationMin;
  late TextEditingController orderDurationTimeController;

  var socket = WebSocketService.socket;

  @override
  void initState() {
    super.initState();

    orderDurationTimeController = TextEditingController(text: 'NA');
    WebSocketService.authenticate();
    socket.on('connect', (_) {
      socket.on('order_status_change', (message) {
        setState(() {
          orderStatus = message['orderStatus'];
          print('recvd $orderStatus');
          // only set one time.
          if (message['orderDurationMin'] != null) {
            print('duration received from backend.');
            // only update duration if it has not been set, or admin sends new duration.
            if (orderDurationMin != message['orderDurationMin']) {
              print('new duration received, updating controller.');
              print(message['orderDurationMin'].runtimeType);
              orderDurationMin = message['orderDurationMin']!;
              orderDurationTimeController.text = orderDurationMin.toString();

              // just for emulating time faster
              int m = 10;
              for (var i = 1; i <= m; i++) {
                Future.delayed(Duration(seconds: i), () {
                  orderDurationTimeController.text = (m - i).toString();
                });
              }
            }
          }
        });
      });
    });
    socket.on('disconnect', (_) {
      print('socket disconnected...');
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    orderDurationTimeController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    TextStyle secStyle = TextStyle(fontSize: 16, color: Colors.grey);

    return Scaffold(
      body: SizedBox(
        child: Center(
          child: FutureBuilder(
              future: cartController.getCurrUserCart(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                Cart cart = snapshot.data as Cart;
                String orderedTime = Jiffy(cart.createdAt).Hms;
                int itemCount = cart.items.length;
                int totalPrice =
                    cart.items.fold(0, (t, e) => t + (e.foodId.price * e.qty));
                List<Item> items = [
                  Item(
                    primaryText: 'Order Received',
                    secondaryText: Text(
                      'Order received at ' + orderedTime,
                      style: secStyle,
                    ),
                    icon: 'assets/images/order_recv.png',
                  ),
                  Item(
                    primaryText: 'Food is being prepared',
                    secondaryText: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Your order will be ready approx. in ',
                          style: secStyle,
                        ),
                        SizedBox(
                          width: 20,
                          child: TextFormField(
                            controller: orderDurationTimeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text(
                          ' minutes',
                          style: secStyle,
                        ),
                      ],
                    ),
                    icon: 'assets/images/order_prep.png',
                  ),
                  Item(
                    primaryText: 'Order Checkout.',
                    secondaryText: Text(
                      'Please collect your order from the kitchen. Have a great meal.',
                      style: secStyle,
                    ),
                    icon: 'assets/images/order_checkout.png',
                  ),
                ];
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: kPrimary.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                icon: Icon(Icons.close),
                                color: Colors.black,
                                iconSize: 25,
                                onPressed: () => Get.offAllNamed('/home'),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #' + utils.shortId(cart.id),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  orderedTime +
                                      ' | ' +
                                      itemCount.toString() +
                                      ' item' +
                                      ', Rs. ' +
                                      totalPrice.toString(),
                                ),
                              ],
                            ),
                            Image(
                              image: AssetImage('assets/images/moreInfo.png'),
                              height: 20,
                              width: 20,
                            )
                          ],
                        )),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                            top: 40,
                            bottom: 0,
                          ),
                          child: OrderStatusItems(
                              orderStatus: orderStatus, items: items)),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}

TextWithColor _getOrderStatus(int? orderStatus, int currIndex) {
  int statusIndex = orderStatus ?? -1;
  if (currIndex > statusIndex) {
    return TextWithColor('Later', Color.fromARGB(255, 204, 188, 46));
  } else if (currIndex < statusIndex) {
    return TextWithColor('Done', Colors.green);
  } else {
    // equals or if index is -1
    return TextWithColor('Pending', Colors.orange);
  }
}

class Item {
  String primaryText;
  Widget secondaryText;
  String icon;
  // TextWithColor status;

  Item(
      {required this.primaryText,
      required this.secondaryText,
      required this.icon});
}

class OrderStatusItems extends StatelessWidget {
  final List<Item> items;
  final int? orderStatus;
  const OrderStatusItems(
      {Key? key, required this.orderStatus, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < items.length; i++) {
      TextWithColor currStatus = _getOrderStatus(orderStatus, i);
      bool isCurrent = i == (orderStatus ?? -1);

      // add border to all
      if (i == items.length - 1) {}
      children.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                  color: Color(0xFFB0CCE1).withOpacity(0.5),
                ),
              ],
            ),
            child: Row(
              children: [
                VerticalLine(
                    first: i == 0,
                    last: i == items.length - 1,
                    status: currStatus.text),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          items[i].icon,
                          // color: Colors.black,
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          currStatus.text,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[i].primaryText,
                            style: TextStyle(
                                height: 1.5,
                                letterSpacing: 0.2,
                                fontWeight: isCurrent
                                    ? FontWeight.w800
                                    : FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child:
                                isCurrent ? items[i].secondaryText : Text(''),
                            // items[i].secondaryText,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      children: children,
    );
  }
}

class TextWithColor {
  final String text;
  final Color color;

  TextWithColor(this.text, this.color);
}

class VerticalLine extends StatelessWidget {
  final bool first;
  final bool last;
  final String status;

  const VerticalLine({
    Key? key,
    this.first = false,
    this.last = false,
    this.status = 'pending',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late IconData statusIcon;
    late Color statusColor1;
    late Color statusColor2;
    if (status == 'Pending') {
      statusIcon = Icons.access_time;
      statusColor1 = Colors.green;
      statusColor2 = Colors.orange;
    } else if (status == 'Done') {
      statusIcon = Icons.check_circle;
      statusColor1 = Colors.green;
      statusColor2 = Colors.green;
    } else if (status == 'Later') {
      statusIcon = Icons.alarm;
      statusColor1 = Colors.orange;
      statusColor2 = Colors.orange;
    }

    List<Widget> children = [
      Expanded(
        child: VerticalDivider(
          color: statusColor1,
          thickness: 3,
        ),
      ),
      Icon(
        statusIcon,
        color: statusColor2,
        size: 20,
      ),
      Expanded(
        child: VerticalDivider(
          color: statusColor2,
          thickness: 3,
        ),
      ),
    ];
    if (first) {
      children[0] = Expanded(child: const Text(''));
    } else if (last) {
      children[children.length - 1] = Expanded(child: const Text(''));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 15.0),
      child: Column(
        children: children,
      ),
    );
  }
}
