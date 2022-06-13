import 'package:byte_bistro/controller/cart_admin_contoller.dart';
import 'package:byte_bistro/models/cart_admin.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';

class OrderHistoryAdmin extends StatefulWidget {
  const OrderHistoryAdmin({Key? key}) : super(key: key);

  @override
  State<OrderHistoryAdmin> createState() => _OrderHistoryAdminState();
}

class _OrderHistoryAdminState extends State<OrderHistoryAdmin> {
  CartAdminController cartAdminController = Get.put(CartAdminController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          onPressed: () {},
        ),
        title: const Text("Invoice History"),
      ),
      body: FutureBuilder(
        future: cartAdminController.getAllCart(),
        builder: (context, snapshot) {
          

         
          if (snapshot.hasData) {
            List<CartAdmin> data = snapshot.data as List<CartAdmin>;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // print("data[index]");
                // print(data[index].userId.id);
                return GestureDetector(
                  onTap: ()=>{
                    Navigator.pushNamed(context, 'invoice_detail')
                  },

                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            data[index].userId.fullname,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(data[index].userId.id.toString()),
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
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text("Order No."),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text("Date"),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Container(
                                      width: 120,
                                      child: Text(
                                        data[index].id.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Container(
                                    width: 120,
                                    child: Text(
                                      data[index].createdAt.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text("Total"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text("Status"),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 20,
                                  ),
                                  child: Container(
                                    width: 100,
                                    child: Text(
                                      "Rs. 827",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                    right: 20,
                                  ),
                                  child: Text(
                                    "Complete",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Empty"),
            );
          }
        },
      ),
    );
  }
}
