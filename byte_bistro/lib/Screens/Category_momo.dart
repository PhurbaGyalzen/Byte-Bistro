import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:byte_bistro/Screens/home/models/food_model.dart';
import '../../../controller/food_controller.dart';
import 'package:get/get.dart';

class MOMO extends StatefulWidget {
  final String catName;
  const MOMO({Key? key, this.catName = ""}) : super(key: key);

  @override
  State<MOMO> createState() => _MOMOState();
}

class _MOMOState extends State<MOMO> {
  FoodController foodController = Get.put(FoodController());
  var momoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 208, 206),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 17, right: 17),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.orange,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 135), //apply padding to all four sides
                    child: Text(
                      widget.catName,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder(
                  future: foodController.getAllFood(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Food> data = snapshot.data as List<Food>;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          if (index == data.length - 1 && momoList.isEmpty) {
                            return Center(
                              child: Text(
                                "Empty",
                              ),
                            );
                          }

                          // ignore: unrelated_type_equality_checks
                          else if (data[index].categories."name" == widget.catName) {
                            momoList.add(data[index]);
                            return Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ), // Image border
                                      child: Image(
                                        image: NetworkImage(data[index].image),
                                        width: 116,
                                        height: 124,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 17),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 13),
                                            child: Text(
                                              data[index].name,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                              'Rs ${data[index].price.toString()}'),
                                          Padding(
                                            padding: EdgeInsets.only(top: 6),
                                            child: SizedBox(
                                              // width: 200,
                                              // height: 59,
                                              child: Text(
                                                data[index].description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                'assets/images/heart.png',
                                                height: 22,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(30, 25),
                                                  primary: Color.fromARGB(
                                                      255, 205, 18, 237),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    // Image.asset(
                                                    //   'assets/images/add_to_cart.png',
                                                    // ),
                                                    Text('Add Cart')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
