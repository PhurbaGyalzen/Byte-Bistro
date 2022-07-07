import 'package:byte_bistro/Screens/admin_order_history_detail.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/admin_order_history_controller.dart';
import 'package:byte_bistro/models/admin_order_history.dart';
import 'package:byte_bistro/models/cart.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AdminOrderHistoryList extends StatefulWidget {
  const AdminOrderHistoryList({Key? key}) : super(key: key);

  @override
  State<AdminOrderHistoryList> createState() => _AdminOrderHistoryListState();
}

class _AdminOrderHistoryListState extends State<AdminOrderHistoryList> {
  num totalPricePass = 0;
  AdminOrderHistoryController adminOrderHistoryController =
      Get.put(AdminOrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: kTextColor,
          onPressed: () => Get.toNamed('/adminScreen'),
        ),
        title: Text(
          "Order History",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: FutureBuilder(
        future:
            AdminOrderHistoryController.getAdminOrderHistoryControllerInfo(),
        builder: (context, snapshot) {
          print("snapshot ${snapshot}");
          print("snapshot.data ${snapshot.data}");

          if (snapshot.hasData) {
            List<AdminOrderHistory> data =
                snapshot.data as List<AdminOrderHistory>;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                int indexTotaL = data[index].items.length;
                late AdminOrderHistory dataIndex = data[index];
                late num totalPrice = 0;
                String date1 = data[index].createdAt.toString();
                date1 = date1.split(" ")[0];

                // print("data[index] ${data[index]}");

                for (int i = 0; i < indexTotaL; i++) {
                  totalPrice += (data[index].items[i].qty *
                      data[index].items[i].foodId.price);
                }
                late num totalPrice2 = totalPrice + totalPrice * 13 ~/ 100;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      totalPricePass = totalPrice;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminOrderHistoryDetail(
                              totalPrice: totalPricePass, data: dataIndex)),
                    );
                    // Navigator.pushNamed(context, 'user_invoice_detail');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Name: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 11,
                              child: Text(
                                data[index].userId.fullname,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20.0,
                                      bottom: 10,
                                    ),
                                    child: Text("Order No:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20.0,
                                    ),
                                    child: Text("Date:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        // left: 10.0,
                                        bottom: 10),
                                    child: SizedBox(
                                        width: 120,
                                        child: Text(
                                          data[index]
                                              .id
                                              .toString()
                                              .substring(10),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        // left: 10.0,
                                        ),
                                    child: SizedBox(
                                      width: 120,
                                      child: Text(
                                        date1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Expanded(
                            //   child: SizedBox(),
                            // ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.0, bottom: 10),
                                    child: Text("Total:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20.0,
                                    ),
                                    child: Text(
                                      "Status:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.0,
                                        // right: 20,
                                        bottom: 10),
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        "Rs. ${totalPrice2.toString()}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 2.0,
                                      right: 20,
                                    ),
                                    child: Text(
                                      CartStatus
                                          .values[data[index].status].name,
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: 3,
                            bottom: 3,
                          ),
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
