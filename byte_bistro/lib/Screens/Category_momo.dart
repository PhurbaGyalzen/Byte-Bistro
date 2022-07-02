import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controller/food_controller.dart';
import 'package:get/get.dart';

class MOMO extends StatefulWidget {
  final String catName;
  const MOMO({Key? key, this.catName = ""}) : super(key: key);

  @override
  State<MOMO> createState() => _MOMOState();
}

class _MOMOState extends State<MOMO> {
  FoodController foodController = Get.put(FoodController());

  var FoodList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.catName,
          style: TextStyle(fontSize: 20, letterSpacing: 1, height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed('/home'),
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 17, right: 17, top: 12),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                  future: foodController.getAllFood(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Food> data = snapshot.data as List<Food>;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index1) {
                          int catLength = data[index1].categories.length;
                          print("cat length $catLength");
                          print("index1 $index1");

                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: data[index1].categories.length,
                            itemBuilder: (context, index) {
                              print("index $index");

                              if (data[index1].categories[index].name ==
                                  widget.catName) {
                                FoodList.add(data[index1]);
                                return Container(
                                  padding: EdgeInsets.only(left: 10, bottom: 0),
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                        color:
                                            Color(0xFFB0CCE1).withOpacity(0.32),
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
                                            10,
                                          ), // Image border

                                          child: CachedNetworkImage(
                                            width: 120,
                                            height: 120,
                                            imageUrl: PersistentHtpp.baseUrl +
                                                data[index1].image,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      'assets/images/loading.gif',
                                                    )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                          ),
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
                                                  data[index1].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1,
                                                ),
                                              ),
                                              Text(
                                                'Rs ${data[index1].price.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: SizedBox(
                                                  // width: 200,
                                                  // height: 59,
                                                  child: Text(
                                                    data[index1].description,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/heart.png',
                                                    height: 20,
                                                    width: 20,
                                                    color: Colors.red
                                                        .withOpacity(0.5),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                      color: kPrimary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
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
                              } else if (index1 == data.length - 1 &&
                                  FoodList.isEmpty) {
                                return Center(
                                  child: Text(
                                    "Empty",
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }

                              // if (index > 0) {
                              //   return SizedBox(
                              //     child: Text("indexCat $index"),
                              //   );
                              // } else {
                              //   return SizedBox(
                              //     child: Text("1<0"),
                              //   );
                              // }
                            },
                          );
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
