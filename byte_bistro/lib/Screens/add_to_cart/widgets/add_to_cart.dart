import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartFood(),
                PaymentSummary(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CartFood
class CartFood extends StatelessWidget {
  const CartFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      margin: EdgeInsets.only(
        top: 20,
      ),
      // height: MediaQuery.of(context).size.height,
      height: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Your Cart',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Food',
              style: TextStyle(fontSize: 20, color: kPrimary),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(
                          top: 20, right: 0, bottom: 10, left: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                            color: Color(0xFFB0CCE1).withOpacity(0.32),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image(
                            image: AssetImage('assets/images/foodlogo.png'),
                            height: 120,
                            width: 120,
                          ),
                          Positioned(
                            top: 30,
                            left: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pizza',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  'Healthy & Delicious',
                                  style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      fontWeight: FontWeight.w200),
                                ),
                                Text(
                                  'Rs 100',
                                  style: TextStyle(
                                    color: kTextLightColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 50,
                            right: 20,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: kPrimary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/minus.png'),
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                    ),
                                    child: Text(
                                      '2',
                                      style: TextStyle(fontSize: 14),
                                    )),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: kPrimary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image(
                                    image: AssetImage('assets/images/add.png'),
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: 85,
                              right: 35,
                              child: Text(
                                'Rs 1000',
                                style: TextStyle(
                                  color: kTextColor,
                                  height: 1.5,
                                ),
                              ))
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}

//PaymentSummary
class PaymentSummary extends StatelessWidget {
  const PaymentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
}

class PromoSearchBox extends StatelessWidget {
  const PromoSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              cursorColor: kPrimary,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hoverColor: kPrimary,
                hintText: 'Promo code',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                prefixIcon: Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    top: 4,
                    bottom: 4,
                    right: 8,
                  ),
                  child: Image(
                      image: AssetImage('assets/images/promoCode.png'),
                      width: 5,
                      height: 5,
                      color: kTextColor.withOpacity(0.5)),
                ),
                prefixIconConstraints:
                    BoxConstraints.expand(width: 40, height: 40),
                suffixIcon: SizedBox(
                  height: 50,
                  width: 80,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 16,
                      top: 8,
                      bottom: 8,
                    ),
                    child: FloatingActionButton(
                        clipBehavior: Clip.hardEdge,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: kTextColor,
                        onPressed: () {},
                        child: Text(
                          'Apply',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: kTextColor),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
