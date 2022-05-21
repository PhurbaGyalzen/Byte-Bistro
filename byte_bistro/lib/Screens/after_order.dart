import 'package:byte_bistro/Services/ws_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io' show Platform;

class AfterOrderScreen extends StatefulWidget {
  AfterOrderScreen({Key? key}) : super(key: key);

  @override
  _AfterOrderScreenState createState() => _AfterOrderScreenState();
}

Map<String, int> ORDER_STATUS = {
  'orderRcvd': 0,
  'orderPrep': 1,
  'orderReady': 2,
  'orderChecked': 3
};

class _AfterOrderScreenState extends State<AfterOrderScreen> {
  String orderId = '123456';
  String orderedTime = '9:33 PM';
  String itemCount = '2';
  String totalPrice = '500.00';
  String? orderStatus;
  int orderDurationMin = 100;

  // var socket = IO.io('http://100.91.255.71:3001', <String, dynamic>{
  //   'transports': ['websocket'],
  //   'autoConnect': false,
  // });
  var socket = WebSocketService.socket;

  @override
  void initState() {
    print('initstate');
    print(WebSocketService.origin);
    socket.connect();
    socket.on('connect', (_) {
      print('connected');
      _mocker();

      socket.on('order_status_change', (message) {
        setState(() {
          orderStatus = message['orderStatus'];
          orderDurationMin = message['orderDurationMin'];
        });
      });
    });
    socket.on('disconnect', (_) {
      print('disconnected');
    });
    super.initState();
  }

  void _mocker() {
    int diff = 3;
    Future.delayed(Duration(seconds: diff * 1), () {
      // should be sent by admin.
      print('orderRcvd');
      socket.emit('order_status_change', [
        {
          'orderId': '123456',
          'orderStatus': 'orderRcvd',
          'orderDurationMin': 20,
        }
      ]);
    });

    Future.delayed(Duration(seconds: diff * 2), () {
      print('orderPrep');
      // should be sent by admin.
      socket.emit('order_status_change', [
        {
          'orderId': '123456',
          'orderStatus': 'orderPrep',
          'orderDurationMin': 20,
        }
      ]);
    });

    Future.delayed(Duration(seconds: diff * 3), () {
      print('orderReady');
      // should be sent by admin.
      socket.emit('order_status_change', [
        {
          'orderId': '123456',
          'orderStatus': 'orderReady',
          'orderDurationMin': 20,
        }
      ]);
    });

    Future.delayed(Duration(seconds: diff * 4), () {
      print('orderChecked');
      // should be sent by admin.
      socket.emit('order_status_change', [
        {
          'orderId': '123456',
          'orderStatus': 'orderChecked',
          'orderDurationMin': 20,
        }
      ]);
    });
  }

  Widget build(BuildContext context) {
    List<Item> items = [
      Item(
        primaryText: 'Order Received',
        secondaryText: 'Order received at ' + orderedTime,
        icon: Icons.fastfood,
      ),
      Item(
        primaryText: 'Food is being prepared',
        secondaryText:
            'Your order will be ready approx. in $orderDurationMin minutes',
        icon: Icons.local_drink,
      ),
      Item(
        primaryText: 'Food is ready',
        secondaryText:
            'Please collect your order from the kitchen. Have a great meal.',
        icon: Icons.local_dining,
      ),
    ];
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.close,
                  color: Colors.blue,
                  size: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #' + orderId,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      orderedTime +
                          ' | ' +
                          itemCount +
                          ' item' +
                          ', Rs. ' +
                          totalPrice,
                    ),
                  ],
                ),
                Icon(
                  Icons.more,
                  color: Colors.blue,
                  size: 50,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 10.0),
                child:
                    OrderStatusItems(orderStatus: orderStatus, items: items)),
          ),
        ]),
      ),
    );
  }
}

TextWithColor _getOrderStatus(String? orderStatus, int currIndex) {
  int statusIndex = ORDER_STATUS[orderStatus] ?? -1;
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
  String secondaryText;
  IconData icon;
  // TextWithColor status;

  Item(
      {required this.primaryText,
      required this.secondaryText,
      required this.icon});
}

class OrderStatusItems extends StatelessWidget {
  final List<Item> items;
  final String? orderStatus;
  const OrderStatusItems(
      {Key? key, required this.orderStatus, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < items.length; i++) {
      TextWithColor currStatus = _getOrderStatus(orderStatus, i);
      bool isCurrent = i == (ORDER_STATUS[orderStatus] ?? -1);

      // add border to all
      BoxDecoration decoration = BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      );
      if (i == items.length - 1) {
        decoration = BoxDecoration();
      }
      children.add(
        Expanded(
          child: Container(
            // decoration: decoration,
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
                        Icon(
                          items[i].icon,
                          color: Colors.black,
                          size: 50,
                        ),
                        Text(
                          currStatus.text,
                          style: TextStyle(color: currStatus.color),
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
                                fontWeight: isCurrent
                                    ? FontWeight.w800
                                    : FontWeight.w500,
                                fontSize: 22),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              isCurrent ? items[i].secondaryText : '',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
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

  VerticalLine({
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
