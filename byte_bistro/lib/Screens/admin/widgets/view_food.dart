// import 'package:byte_bistro/Models/food.dart';
import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/Services/food_services.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class ViewFood extends StatefulWidget {
  const ViewFood({Key? key}) : super(key: key);

  @override
  State<ViewFood> createState() => _ViewFoodState();
}

class _ViewFoodState extends State<ViewFood> {
  FoodService foodService = FoodService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: FoodService.getAllFood(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Food> data = snapshot.data as List<Food>;
            return SizedBox(
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
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                          color: Color(0xFFB0CCE1).withOpacity(0.32),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 1.3,
                            letterSpacing: 0.5,
                            color: kTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                data[index].description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5,
                                  color: kTextLightColor,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/foodlogo.png')))
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs ${data[index].price.toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                height: 1.3,
                                letterSpacing: 0.5,
                                color: kTextColor,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            GestureDetector(
                              onTap: () => showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Delete'),
                                      content: Text(
                                          'Are you sure you want to delete this item?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                          onPressed: () {
                                            foodService
                                                .deleteFood(data[index].id);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              child: Image(
                                image: AssetImage('assets/images/delete.png'),
                                width: 25,
                                height: 25,
                                color: Colors.red,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
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
    );
  }
}
