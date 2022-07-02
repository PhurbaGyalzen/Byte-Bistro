import 'package:byte_bistro/Screens/admin/widgets/pending_orders.dart';
import 'package:byte_bistro/Services/ws_service.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
// import 'admin_order_detail.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({Key? key}) : super(key: key);
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  var socket = WebSocketService.socket;
  
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    // should connect again?
    // socket.connect();
    WebSocketService.authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kTextColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Food Orders',
          style: TextStyle(color: kTextColor, fontSize: 16),
        ),
        actions: [
          Stack(children: [
            Padding(
              padding: EdgeInsets.only(right: 25, top: 5),
              child: Image(
                image: AssetImage('assets/images/notification.png'),
                height: 20,
                width: 20,
                color: kTextColor,
              ),
            ),
            Positioned(
              right: 20,
              top: 2,
              child: Container(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                decoration: BoxDecoration(
                  color: kTextColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  '1',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: cartController.getPendingOrders(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    List<Cart> data = snapshot.data as List<Cart>;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        Cart cart = data[index];
                        return PendingOrders(
                            socket: socket,
                            cart: cart,
                            orderStatusId: cart.status);
                      }),
                    );
                  }))),
    );
  }
}
