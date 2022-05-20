// import 'package:byte_bistro/Models/food.dart';
import 'package:byte_bistro/Screens/home/models/food_model.dart';
import 'package:byte_bistro/Services/food_services.dart';
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
              height: 500,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(child: Text(data[index].name));
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
