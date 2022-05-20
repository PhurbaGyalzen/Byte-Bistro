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
            return Center(
              child: Text('Data'),
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
