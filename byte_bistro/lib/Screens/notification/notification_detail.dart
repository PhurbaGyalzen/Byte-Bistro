import 'package:byte_bistro/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class NotificationDetail extends StatelessWidget {
  final Cart order;
  int totalCartPrice = 0;
  NotificationDetail({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: ListView(children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ${order.id}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Order Status: ${order.id}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Order Date: ${order.createdAt}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Order Total: ${totalCartPrice}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Order Items:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount: order.items.length,
                            itemBuilder: (context, index) {
                              totalCartPrice +=
                                  order.items[index].foodId.price *
                                      order.items[index].qty;
                              return ListTile(
                                title: Text(order.items[index].foodId.name),
                                subtitle: Text(
                                  '${order.items[index].qty} x ${order.items[index].foodId.price} = ${order.items[index].foodId.price * order.items[index].qty}',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
