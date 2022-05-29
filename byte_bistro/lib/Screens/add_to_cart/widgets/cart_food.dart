// CartFood
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants/colors.dart';

class CartFood extends StatelessWidget {
  const CartFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            Container(
              padding: EdgeInsets.only(
                left: 10,
                top: 20,
                right: 10,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                    color: Color(0xFFB0CCE1).withOpacity(0.2),
                  ),
                ],
              ),
              child: SizedBox(
                height: 400,
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                  children: const [
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
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/minusBorder.png'),
                                          height: 20,
                                          width: 20,
                                        )),
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
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/add.png'),
                                          height: 20,
                                          width: 20,
                                        )),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 90,
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
            ),
          ],
        ),
      ),
    );
  }
}
