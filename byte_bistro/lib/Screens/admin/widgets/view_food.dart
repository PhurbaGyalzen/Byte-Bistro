// import 'package:byte_bistro/Models/food.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../controller/food_controller.dart';

class ViewFood extends StatelessWidget {
  const ViewFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodController controller = Get.put(FoodController());
    TextEditingController searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Food',
          style: Theme.of(context).textTheme.bodyText1,
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
              hintText: 'Search',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black26,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.black26,
                ),
                onPressed: () {
                  searchController.clear();
                },
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
          child: GetBuilder<FoodController>(
            builder: (controller) => ListView.builder(
              itemCount: controller.foodList.length,
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
                          controller.setFoodUnavailable(
                              controller.foodList[index].id);
                          Get.offNamed('/adminScreen');

                          // setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Food Set Unavailable')),
                          );
                        }),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (value) {
                              controller.foodList.removeAt(index);
                              // setState(() {});
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
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 200.0,
                              child: Image(
                                  height: 120,
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/' +
                                      controller.foodList[index].image)),
                            ),
                          ),
                        ),
                        title: Text(controller.foodList[index].name),
                        subtitle: Text('Rs : ' +
                            controller.foodList[index].price.toString()),
                        dense: false,
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
