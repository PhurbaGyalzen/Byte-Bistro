import 'package:byte_bistro/Screens/user_invoice_detail.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/user_invoice_controller.dart';
import 'package:byte_bistro/models/user_invoice_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserInvoiceList extends StatefulWidget {
  const UserInvoiceList({Key? key}) : super(key: key);

  @override
  State<UserInvoiceList> createState() => _UserInvoiceListState();
}

class _UserInvoiceListState extends State<UserInvoiceList> {
  num totalPricePass = 0;
  UserInvoiceController userInvoiceController =
      Get.put(UserInvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: kTextColor,
          onPressed: () => Get.toNamed('/profile_screen'),
        ),
        title: Text(
          "Invoice History",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: FutureBuilder(
        future: userInvoiceController.getUserInvoiceControllerInfo(),
        builder: (context, snapshot) {
    

          if (snapshot.hasData) {
            List<UserInvoiceModel> data =
                snapshot.data as List<UserInvoiceModel>;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                int indexTotaL = data[index].items.length;
                late UserInvoiceModel dataIndex = data[index];
                late num totalPrice = 0;
                String date1 = data[index].createdAt.toString();
                date1 = date1.split(" ")[0];


                for (int i = 0; i < indexTotaL; i++) {
                  totalPrice += (data[index].items[i].qty *
                      data[index].items[i].foodId.price.toInt());
                }
                late num totalPrice2 = totalPrice + totalPrice * 13 ~/ 100;

                // print("data[index]");
                // print(data[index].userId.id);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      totalPricePass = totalPrice;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserInvoiceDetail(
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
                                      "Complete",
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
