import 'package:flutter/material.dart';

class AfterOrderScreen extends StatefulWidget {
  AfterOrderScreen({Key? key}) : super(key: key);

  @override
  _AfterOrderScreenState createState() => _AfterOrderScreenState();
}

class _AfterOrderScreenState extends State<AfterOrderScreen> {
  @override
  String orderId = '123456';
  String orderedTime = '9:33 PM';
  String itemCount = '2';
  String totalPrice = '500.00';

  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(children: [
                Expanded(
                  child: Row(
                    children: [
                      VerticalLine(first: true),
                      Row(
                        children: [
                          Icon(
                            Icons.local_dining,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            'Order Received',
                            style: TextStyle(fontSize: 20),
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
                          Icon(
                            Icons.local_drink,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            'Food is being prepared',
                            style: TextStyle(fontSize: 20),
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
                          Icon(
                            Icons.local_bar,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            'Food is ready. Please collect.',
                            style: TextStyle(fontSize: 20),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: children,
      ),
    );
  }
}
