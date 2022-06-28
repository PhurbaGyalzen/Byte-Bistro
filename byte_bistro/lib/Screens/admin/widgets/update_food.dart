import 'dart:io';

import 'package:byte_bistro/Screens/admin/widgets/admin_dashboard.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

class UpdateFood extends StatefulWidget {
  const UpdateFood({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateFood> createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  List data = Get.arguments;

  late final nameController = TextEditingController(text: data[1]['name']);
  late final priceController =
      TextEditingController(text: data[2]['price'].toString());
  // late final imageController = TextEditingController(text: data[4]['image']);
  late final descriptionController =
      TextEditingController(text: data[3]['description']);
  File? image;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    priceController.addListener(() => setState(() {}));
    // imageController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FoodController foodController = Get.put(FoodController());
    // var data = Get.arguments();
    // print(data);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Food',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: kPrimary,
        foregroundColor: kTextColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Food Details',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ],
                      ),
                    ),
                    nameField('widget.name'),
                    SizedBox(
                      height: 20,
                    ),
                    priceField(),
                    SizedBox(
                      height: 20,
                    ),
                    // imageField(),
                    SizedBox(
                      height: 20,
                    ),
                    descriptionField(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimary.withOpacity(0.8),
                            onPrimary: kTextColor,
                            minimumSize: Size(100, 40),
                          ),
                          onPressed: () async {
                            if (formKey.currentState?.validate() == true) {
                              Map<String, dynamic> dataInfo = {
                                "name": nameController.text,
                                "price": priceController.text,
                                "description": descriptionController.text,
                              };

                              // print(imageController.text);
                              String foodId = data[0]['id'];
                              print('the food is $foodId');
                              String response = await foodController.updateFood(
                                  foodId, dataInfo);
                

                              if (response == "success") {
                                Navigator.pushNamed(context, '/adminScreen')
                                    .then((_) {
                                  // This block runs when you have returned back to the 1st Page from 2nd.
                                  setState(() {
                                    // Call setState to refresh the page.
                                  });
                                });

                                Get.snackbar(
                                  "Success",
                                  "Food Updated Successfully",
                                  icon: Icon(Icons.check,
                                      color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.TOP,
                                );
                      
                                foodController.getAllFood();
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Food Update Failed",
                                  icon: Icon(Icons.warning,
                                      color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  animationDuration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.TOP,
                                );
                                
                              }
                            }
                          },
                          child: Text(
                            'UPDATE',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  TextFormField nameField(String name) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: nameController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Name'),
        suffixIcon: nameController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => nameController.clear(),
              ),
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required *'),
      ]),
    );
  }

  TextFormField priceField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: priceController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Price'),
        suffixIcon: priceController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => priceController.clear(),
              ),
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required *'),
      ]),
    );
  }

  TextFormField descriptionField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: descriptionController,
      minLines:
          6, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Description'),
        suffixIcon: descriptionController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => descriptionController.clear(),
              ),
      ),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Required *'),
      ]),
    );
  }
}
