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
  'orderReady': 2
};

class _AfterOrderScreenState extends State<AfterOrderScreen> {
  String orderId = '123456';
  String orderedTime = '9:33 PM';
  String itemCount = '2';
  String totalPrice = '500.00';
  String orderStatus = 'orderRcvd';
  int orderDurationMin = 100;

  // var socket = IO.io('http://100.91.255.71:3001', <String, dynamic>{
  //   'transports': ['websocket'],
  //   'autoConnect': false,
  // });
  var socket = WebSocketService.socket;

  @override
  void initState() {
    print('initstate');
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
    Future.delayed(Duration(seconds: 2), () {
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

    Future.delayed(Duration(seconds: 10), () {
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

    Future.delayed(Duration(seconds: 15), () {
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
  }

  Widget build(BuildContext context) {
    List<Item> items = [
      Item(
        primaryText: 'Order Received',
        secondaryText: 'Order received on ' + orderedTime,
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

TextWithColor _getOrderStatus(String orderStatus, int currIndex) {
  int statusIndex = ORDER_STATUS[orderStatus]!;
  if (currIndex == statusIndex) {
    return TextWithColor('Now', Colors.orange);
  } else if (currIndex < statusIndex) {
    return TextWithColor('Done', Colors.green);
  } else {
    return TextWithColor('Later', Color.fromARGB(255, 204, 188, 46));
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
  final String orderStatus;
  const OrderStatusItems(
      {Key? key, required this.orderStatus, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < items.length; i++) {
      children.add(
        Expanded(
          child: Row(
            children: [
              VerticalLine(first: i == 0, last: i == items.length - 1),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[i].icon,
                        color: Colors.blue,
                        size: 50,
                      ),
                      Text(
                        _getOrderStatus(orderStatus, i).text,
                        style: TextStyle(
                            color: _getOrderStatus(orderStatus, i).color),
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
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            items[i].secondaryText,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
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

  VerticalLine({
    Key? key,
    this.first = false,
    this.last = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      VerticalDivider(
        color: Color.fromARGB(255, 153, 150, 150),
        thickness: 3,
      ),
      VerticalDivider(
        color: Color.fromARGB(255, 153, 150, 150),
        thickness: 3,
      ),
    ];
    if (first) {
      children[0] = const Text('');
    } else if (last) {
      children[1] = const Text('');
    }
    for (int i = 0; i < children.length; i++) {
      children[i] = Expanded(
        child: children[i],
      );
    }
    children.insert(
      1,
      Icon(
        Icons.circle_outlined,
        color: Color.fromARGB(255, 153, 150, 150),
        size: 20,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: children,
      ),
    );
  }
}
