// import 'package:byte_bistro/Models/food.dart';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../controller/food_controller.dart';

class ViewFood extends StatelessWidget {
  const ViewFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodController foodController = Get.find();
    TextEditingController searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Food',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            GestureDetector(
              onTap: () => foodController.getAllFood(),
              child: Image(
                image: AssetImage('assets/images/getAllFood.png'),
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // search bar
        Container(
          margin: EdgeInsets.only(
            bottom: searchController.text.isEmpty ? 0 : 10,
          ),
          decoration: BoxDecoration(
            color: kTextColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              hintText: 'Search',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black26,
                ),
                onPressed: () =>
                    foodController.searchFood(searchController.text),
              ),
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        ),

        // food list
        SizedBox(
          height: 400,
          child: Obx(
            () => ListView.builder(
              itemCount: foodController.foodList.length,
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
                          offset: Offset(0, 3), // changes position of shadow
                          color: Color(0xFFB0CCE1).withOpacity(0.32),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: foodController.foodList[index].isAvailable,
                            onChanged: (value) {
                              if (!value) {
                                var response =
                                    foodController.setFoodUnavailable(
                                        foodController.foodList[index].id);
                              } else {
                                foodController.setFoodAvailable(
                                    foodController.foodList[index].id);
                              }
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed('/updateFood', arguments: [
                              {"id": foodController.foodList[index].id},
                              {"name": foodController.foodList[index].name},
                              {"price": foodController.foodList[index].price},
                              {
                                "description":
                                    foodController.foodList[index].description
                              },
                              {"image": foodController.foodList[index].image},
                            ]),
                            child: Image(
                              image: AssetImage('assets/images/edit.png'),
                              width: 25,
                              height: 25,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      leading: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () =>
                            Get.toNamed('/adminFoodDetail', arguments: [
                          {"id": foodController.foodList[index].id},
                          {"name": foodController.foodList[index].name},
                          {"price": foodController.foodList[index].price},
                          {
                            "description":
                                foodController.foodList[index].description
                          },
                          {"image": foodController.foodList[index].image},
                        ]),
                        child: Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 200.0,
                            child: SizedBox(
                              height: 120,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: PersistentHtpp.baseUrl +
                                    foodController.foodList[index].image,
                                placeholder: (context, url) => Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/loading.gif',
                                    )),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(foodController.foodList[index].name),
                      subtitle: Text('Rs : ' +
                          foodController.foodList[index].price.toString()),
                      dense: false,
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
