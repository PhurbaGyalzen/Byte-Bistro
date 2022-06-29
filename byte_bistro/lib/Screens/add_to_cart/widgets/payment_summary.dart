//PaymentSummary
import 'package:byte_bistro/Services/http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        Container(
          padding: EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Payment Summary',
                    style: Theme.of(context).textTheme.headline1,
                  )),
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
              Padding(
                  padding: EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.headline1,
                  )),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image(
                          image: AssetImage('assets/images/dollar.png'),
                          height: 30,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pay with Cash',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _initPayment(product);
                },
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: AssetImage('assets/images/esewa_logo.png'),
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pay with Esewa',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
