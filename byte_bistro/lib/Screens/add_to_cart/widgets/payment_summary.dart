//PaymentSummary
import 'package:byte_bistro/Screens/add_to_cart/widgets/promo_search_box.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PromoSearchBox(),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        height: 1.5,
                      ),
                    ),
                    Text('Rs 500.0'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        height: 1.5,
                      ),
                    ),
                    Text('Rs 0.0'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tax',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        height: 1.5,
                      ),
                    ),
                    Text('Rs 20.0'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        height: 1.5,
                      ),
                    ),
                    Text('Rs 520.0'),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimary,
                    minimumSize: const Size(350, 50),
                    maximumSize: const Size(450, 50),
                  ),
                  child: Text(
                    'CHECKOUT',
                    style: TextStyle(
                      color: kTextColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  onPressed: () {
                    _initPayment("product");
                  },
                  // style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(kPrimary)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // _initPayment(Map<String, dynamic> product) {
  _initPayment(String product) {
    ESewaConfiguration esewaConfiguration = ESewaConfiguration(
        clientID: "<Client-ID>",
        secretKey: "<Secret-Key>",
        environment: ESewaConfiguration.ENVIRONMENT_TEST);

    ESewaPnp _esewaPnp = ESewaPnp(configuration: esewaConfiguration);

    // ESewaPayment esewaRequest = ESewaPayment(
    //     amount: product["amount"],
    //     productName: "Test Product",
    //     productID: "Test Product ID",
    //     callBackURL: "http://localhost:8080/esewa/callback");
  }
}
