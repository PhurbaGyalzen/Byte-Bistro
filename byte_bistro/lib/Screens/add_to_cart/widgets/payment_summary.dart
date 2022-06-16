//PaymentSummary
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = {
      "cartId": "98023gjhfsdfn",
      "items": [
        {"foodId": "yqhediufhw", "qty": 7},
        {"foodId": "yqhediufhw", "qty": 7}
      ],
      "total": 500.0,
      "promoCode": ""
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PromoSearchBox(),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
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
                children: const [
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
                children: const [
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
                children: const [
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
                  _initPayment(product);
                },
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(kPrimary)),
              )
            ],
          ),
        ),
      ],
    );
  }

  _initPayment(Map<String, dynamic> product) {
    // _initPayment(String product) {
    ESewaConfiguration esewaConfiguration = ESewaConfiguration(
        clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
        secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
        environment: ESewaConfiguration.ENVIRONMENT_TEST);

    ESewaPnp _esewaPnp = ESewaPnp(configuration: esewaConfiguration);

    ESewaPayment _payment = ESewaPayment(
        amount: product['total'],
        productName: "table Number",
        productID: product['cartId'],
        callBackURL: "http://100.102.33.101:3000/cart/");

    try {
      final _res = _esewaPnp.initPayment(payment: _payment);
      // print(_res);
      // Handle success
    } on ESewaPaymentException catch (e) {
      // Handle error
      // print(e.message);
    }
  }
}
