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
    int statusIndex = ORDER_STATUS[orderStatus]!;
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
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
              child: Column(children: [
                Expanded(
                  child: Row(
                    children: [
                      VerticalLine(first: true),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_dining,
                                color: Colors.blue,
                                size: 50,
                              ),
                              Text(
                                _getOrderStatus(0).text,
                                style:
                                    TextStyle(color: _getOrderStatus(0).color),
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
                                  'Order Received',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    'Order received on ' + orderedTime,
                                    // '',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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
                Expanded(
                  child: Row(
                    children: [
                      VerticalLine(),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_drink,
                                color: Colors.blue,
                                size: 50,
                              ),
                              Text(
                                _getOrderStatus(1).text,
                                style:
                                    TextStyle(color: _getOrderStatus(1).color),
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
                                  'Food is being prepared',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    'Your order will be ready approx. in $orderDurationMin minutes',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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
                Expanded(
                  child: Row(
                    children: [
                      VerticalLine(last: true),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_dining,
                                color: Colors.blue,
                                size: 50,
                              ),
                              Text(
                                _getOrderStatus(2).text,
                                style:
                                    TextStyle(color: _getOrderStatus(2).color),
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
                                  'Food ready.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    'Please collect your order from the kitchen. Have a great meal.',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  TextWithColor _getOrderStatus(int currIndex) {
    int statusIndex = ORDER_STATUS[orderStatus]!;
    if (currIndex == statusIndex) {
      return TextWithColor('Now', Colors.orange);
    } else if (currIndex < statusIndex) {
      return TextWithColor('Done', Colors.green);
    } else {
      return TextWithColor('Later', Color.fromARGB(255, 204, 188, 46));
    }
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
