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
  UpdateFood(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.image})
      : super(key: key);
  String id;
  String name;
  int price;
  String description;
  String image;

  @override
  State<UpdateFood> createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  late final nameController = TextEditingController(text: widget.name);
  late final priceController =
      TextEditingController(text: widget.price.toString());
  late final imageController = TextEditingController(text: widget.image);
  late final descriptionController =
      TextEditingController(text: widget.description);
  File? image;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    priceController.addListener(() => setState(() {}));
    imageController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FoodController foodController = Get.put(FoodController());

    return Form(
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
                      'UPDATE FOOD',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirm Navigation'),
                            content: Text(
                                'Are you sure you want to leave this window?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Cancel')),
                              TextButton(
                                onPressed: () {
                                  Get.off(() => AdminDashboard());
                                },
                                child: Text(
                                  'Leave',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kTextLightColor.withOpacity(0.2),
                        ),
                        child: Image(
                          height: 25,
                          width: 25,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/cross.png'),
                          color: kTextLightColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              nameField(widget.name),
              SizedBox(
                height: 20,
              ),
              priceField(),
              SizedBox(
                height: 20,
              ),
              imageField(),
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
                      primary: kTextLightColor.withOpacity(0.3),
                      onPrimary: kTextColor,
                      minimumSize: Size(50, 40),
                    ),
                    onPressed: () => {
                      nameController.clear(),
                      priceController.clear(),
                      imageController.clear(),
                      descriptionController.clear(),
                    },
                    child: Text(
                      'CLEAR',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimary.withOpacity(0.8),
                      onPrimary: kTextColor,
                      minimumSize: Size(75, 40),
                    ),
                    onPressed: () async {
                      if (formKey.currentState?.validate() == true) {
                        Map<String, dynamic> data = {
                          "name": nameController.text,
                          "price": priceController.text,
                          "description": descriptionController.text,
                          "image": imageController.text,
                        };

                        print(imageController.text);

                        String response =
                            await foodController.updateFood(widget.id, data);
                        final snackbarSucess =
                            SnackBar(content: Text('Food updated sucessfully'));
                        final snackbarFail =
                            SnackBar(content: Text('Food updation failed'));

                        if (response == "success") {
                          Navigator.pushNamed(context, '/adminScreen')
                              .then((_) {
                            // This block runs when you have returned back to the 1st Page from 2nd.
                            setState(() {
                              // Call setState to refresh the page.
                            });
                          });

                          snackbarSucess;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbarSucess);
                          foodController.getAllFood();
                        } else {
                          snackbarFail;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbarSucess);
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

  TextFormField imageField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: imageController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Image'),
        suffixIcon: imageController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => imageController.clear(),
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
