// import 'package:clip_shadow/clip_shadow.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/food.dart';

class IndividualItemScreen extends StatefulWidget {
  const IndividualItemScreen({Key? key}) : super(key: key);

  @override
  _IndividualItemScreenState createState() => _IndividualItemScreenState();
}

class _IndividualItemScreenState extends State<IndividualItemScreen> {
  int _orderCount = 1;
  Food? food;
  FoodController foodController = Get.put(FoodController());

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    // final response = await http.get(
    //     Uri.parse('http://100.91.255.71:3000/food/628206498631b1137a449361'));
    // final jsonResponse = (response.body);
    setState(() {
      food = foodController.getSingleFood("628206498631b1137a449361");
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('rendering IndividualItem');
    // print('state is: $_orderCount');
    if (food == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              'assets/images/pizza.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.4],
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.black.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                            ),
                            SizedBox(
                              height: 780,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      height: 700,
                                      width: double.infinity,
                                      decoration: const ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //dish name to number of portions
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 30,
                                              horizontal: 28,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // 'Mulberry Pizza',
                                                  food?.data.name ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                'assets/images/star_filled.png'),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Text(
                                                              '4.6',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .orange,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            const Text(
                                                                '(234) Rating'),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: const [
                                                          Text("Price : Rs 200")
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  'Discription',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  food?.data.description ?? '',
                                                  textAlign: TextAlign.justify,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Divider(
                                                  thickness: 1.5,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Customize your order',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Order Count",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .blue),
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            5.0)),
                                                            onPressed: () {
                                                              if (_orderCount >
                                                                  1) {
                                                                setState(() {
                                                                  _orderCount--;
                                                                });
                                                              }
                                                            },
                                                            child:
                                                                const Text("-"),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            height: 35,
                                                            width: 55,
                                                            decoration:
                                                                const ShapeDecoration(
                                                              shape:
                                                                  StadiumBorder(
                                                                side: BorderSide(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              decoration:
                                                                  const InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                  20.0,
                                                                  15.0,
                                                                  20.0,
                                                                  15.0,
                                                                ),
                                                              ),
                                                              key: Key(_orderCount
                                                                  .toString()),
                                                              onSaved: (value) {
                                                                setState(() {
                                                                  _orderCount =
                                                                      int.parse(
                                                                          value!);
                                                                });
                                                              },
                                                              initialValue:
                                                                  _orderCount
                                                                      .toString(),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .blue),
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            5.0)),
                                                            onPressed: () {
                                                              setState(() {
                                                                _orderCount++;
                                                              });
                                                            },
                                                            child:
                                                                const Text("+"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          //add to card whole section start
                                          SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(40),
                                                        bottomRight:
                                                            Radius.circular(40),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //add card white part
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    height: 160,
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 70,
                                                      right: 58,
                                                    ),
                                                    decoration:
                                                        const ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  40),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                      shadows: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0xFFB6B7B7),
                                                          offset: Offset(0, 5),
                                                          blurRadius: 5,
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Text(
                                                            "Total Price"),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Rs 2300',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          width: 150,
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  Colors.blue,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/add_to_cart.png',
                                                                ),
                                                                const Text(
                                                                    'Add to Cart')
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  //add fav
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     right: 20,
                                  //   ),
                                  //   child: Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: ClipShadow(
                                  //       clipper: CustomTriangle(),
                                  //       boxShadow: const [
                                  //         BoxShadow(
                                  //           color: Color(0xFFB6B7B7),
                                  //           offset: Offset(0, 5),
                                  //         )
                                  //       ],
                                  //       child: GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               _isFav = !_isFav;
                                  //             });
                                  //           },
                                  //           child: Container(
                                  //             width: 60,
                                  //             height: 60,
                                  //             color: Colors.white,
                                  //             child: Image.asset(
                                  //                 'assets/images/' +
                                  //                     (_isFav
                                  //                         ? 'fav_filled.png'
                                  //                         : 'fav.png')),
                                  //           )),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 35,
              left: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      Image.asset('assets/images/cart_white.png')
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class CustomTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlpoint = Offset(size.width * 0, size.height * 0.5);
    Offset endpoint = Offset(size.width * 0.2, size.height * 0.85);
    Offset controlpoint2 = Offset(size.width * 0.33, size.height);
    Offset endpoint2 = Offset(size.width * 0.6, size.height * 0.9);
    Offset controlpoint3 = Offset(size.width * 1.4, size.height * 0.5);
    Offset endpoint3 = Offset(size.width * 0.6, size.height * 0.1);
    Offset controlpoint4 = Offset(size.width * 0.33, size.height * 0);
    Offset endpoint4 = Offset(size.width * 0.2, size.height * 0.15);

    Path path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.15)
      ..quadraticBezierTo(
        controlpoint.dx,
        controlpoint.dy,
        endpoint.dx,
        endpoint.dy,
      )
      ..quadraticBezierTo(
        controlpoint2.dx,
        controlpoint2.dy,
        endpoint2.dx,
        endpoint2.dy,
      )
      ..quadraticBezierTo(
        controlpoint3.dx,
        controlpoint3.dy,
        endpoint3.dx,
        endpoint3.dy,
      )
      ..quadraticBezierTo(
        controlpoint4.dx,
        controlpoint4.dy,
        endpoint4.dx,
        endpoint4.dy,
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
