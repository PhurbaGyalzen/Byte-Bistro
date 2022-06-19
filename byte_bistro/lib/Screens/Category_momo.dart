import 'package:byte_bistro/constants/colors.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 17, right: 17, top: 12),
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
                      color: kTextColor,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.catName,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: FutureBuilder(
                  future: foodController.getAllFood(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Food> data = snapshot.data as List<Food>;
                      print(" data.length ${data.length}");

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          print("data[index].categories ${data[index].categories}");
                          // print(
                          //     "data[index].categories[0]['name'] ${data[index].categories[0]['name']}");

                          if (data[index].categories[0]["name"] ==
                              widget.catName) {
                            momoList.add(data[index]);
                            return Container(
                              padding: EdgeInsets.only(left: 10, bottom: 0),
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                    color: Color(0xFFB0CCE1).withOpacity(0.32),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ), // Image border
                                    child: Image(
                                      image: NetworkImage(data[index].image),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, bottom: 2),
                                            child: Text(
                                              data[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
                                            ),
                                          ),
                                          Text(
                                            'Rs ${data[index].price.toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: SizedBox(
                                              // width: 200,
                                              // height: 59,
                                              child: Text(
                                                data[index].description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                'assets/images/heart.png',
                                                height: 20,
                                                width: 20,
                                                color:
                                                    Colors.red.withOpacity(0.5),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  color: kPrimary,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Image.asset(
                                                  'assets/images/addCart.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (index == data.length - 1 && momoList.isEmpty) {
                            return Center(
                              child: Text(
                                "Empty",
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
