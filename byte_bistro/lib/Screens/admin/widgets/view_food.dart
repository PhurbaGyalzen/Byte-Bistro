// import 'package:byte_bistro/Models/food.dart';
import 'package:byte_bistro/Screens/admin/widgets/update_food.dart';
import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/food_controller.dart';

class ViewFood extends StatefulWidget {
  const ViewFood({Key? key}) : super(key: key);

  @override
  State<ViewFood> createState() => _ViewFoodState();
}

class _ViewFoodState extends State<ViewFood> {
  FoodController foodController = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: foodController.getAllFood(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Food> data = snapshot.data as List<Food>;
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                child: TextField(
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'search',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(15)),
                ),
              ),
              SizedBox(
                height: 600,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: 355,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 5,
                          right: 5,
                          bottom: 8,
                        ),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                              color: Color(0xFFB0CCE1).withOpacity(0.32),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: UniqueKey(),
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            // dismissible: DismissiblePane(onDismissed: () {}),
                            dismissible: DismissiblePane(onDismissed: () {
                              // foodController.deleteFood(data[index].id);
                              foodController.setFoodUnavailable(data[index].id);
                              Get.offNamed('/adminScreen');

                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Food Set Unavailable')),
                              );
                            }),

                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (value) {
                                  data.removeAt(index);
                                  setState(() {});
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.edit_outlined,
                                label: 'Set Unavailable',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {},
                              child: Container(
                                width: 48,
                                height: 48,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 200.0,
                                  child: Image(
                                      height: 120,
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/images/' +
                                          data[index].image)),
                                ),
                              ),
                            ),
                            title: Text(data[index].name),
                            subtitle:
                                Text('Rs : ' + data[index].price.toString()),
                            dense: false,
                          ),
                        )
                        // child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       data[index].name,
                        //       style: Theme.of(context).textTheme.headline2,
                        //     ),
                        //     SizedBox(
                        //       height: 10,
                        //     ),
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Expanded(
                        //           flex: 2,
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(right: 8.0),
                        //             child: Text(data[index].description,
                        //                 style: Theme.of(context).textTheme.bodyText1),
                        //           ),
                        //         ),
                        //         Expanded(
                        //             child: Container(
                        //           margin: EdgeInsets.only(left: 10),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(10),
                        //             child: Image(
                        //                 height: 120,
                        //                 fit: BoxFit.cover,
                        //                 image: AssetImage(
                        //                     'assets/images/' + data[index].image)),
                        //           ),
                        //         ))
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       height: 50,
                        //     ),
                        //     Row(
                        //       children: [
                        //         Text(
                        //           'Rs ${data[index].price.toString()}',
                        //           style: Theme.of(context).textTheme.bodyText1,
                        //         ),
                        //         SizedBox(
                        //           width: 220,
                        //         ),
                        //         GestureDetector(
                        //           onTap: () => showDialog(
                        //               barrierDismissible: false,
                        //               context: context,
                        //               builder: (context) {
                        //                 return AlertDialog(
                        //                   title: Text('Delete'),
                        //                   content: Text(
                        //                       'Are you sure you want to delete this item?'),
                        //                   actions: [
                        //                     TextButton(
                        //                         onPressed: () {
                        //                           Get.back();
                        //                         },
                        //                         child: Text('Cancel')),
                        //                     TextButton(
                        //                       onPressed: () {
                        //                         foodController
                        //                             .deleteFood(data[index].id);
                        //                         setState(() {});
                        //                         Get.back();
                        //                       },
                        //                       child: Text(
                        //                         'Delete',
                        //                         style: TextStyle(color: Colors.red),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 );
                        //               }),
                        //           child: Image(
                        //             image: AssetImage('assets/images/delete.png'),
                        //             width: 20,
                        //             height: 20,
                        //             color: Colors.red.withOpacity(0.5),
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         GestureDetector(
                        //           onTap: () => showMaterialDialog(
                        //             data[index].id,
                        //             data[index].name,
                        //             data[index].price,
                        //             data[index].description,
                        //             data[index].image,
                        //           ),
                        //           child: Image(
                        //             image: AssetImage('assets/images/edit.png'),
                        //             width: 20,
                        //             height: 20,
                        //             color: Colors.black.withOpacity(0.5),
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        );
                  },
                ),
              ),
            ],
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
    );
  }

  void showMaterialDialog(
      String id, String name, int price, String description, String image) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Dialog(
              insetAnimationCurve: Curves.fastOutSlowIn,
              insetAnimationDuration: Duration(seconds: 2),
              elevation: 10,
              insetPadding: EdgeInsets.all(10),
              backgroundColor: Colors.white,
              child: UpdateFood(
                  id: id,
                  name: name,
                  price: price,
                  description: description,
                  image: image),
            ),
          );
        });
  }
}
