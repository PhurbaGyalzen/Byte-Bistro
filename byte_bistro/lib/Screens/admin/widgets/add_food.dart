import 'dart:io';

import 'package:byte_bistro/Screens/admin/widgets/admin_dashboard.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:byte_bistro/Services/food_services.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    priceController.addListener(() => setState(() {}));
    imageController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() => this.image = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

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
                      'ADD FOOD',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.1,
                        wordSpacing: 0.2,
                        color: kTextColor,
                      ),
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
                          }),
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
              nameField(),
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
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.grey,
              //     onPrimary: Colors.white,
              //   ),
              //   onPressed: () {
              //     pickImage();
              //   },
              //   child: Text(
              //     'Pick img gallery',
              //     style: TextStyle(fontSize: 18, letterSpacing: 0.3),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.grey,
              //     onPrimary: Colors.white,
              //   ),
              //   onPressed: () => dismissDialog(),
              //   child: Text(
              //     'Pick img camera',
              //     style: TextStyle(fontSize: 18, letterSpacing: 0.3),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kTextLightColor.withOpacity(0.6),
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
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.3,
                          color: Colors.white),
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

                        String response = await foodController.addFood(data);
                        final snackbarSucess =
                            SnackBar(content: Text('Food added sucessfully'));
                        final snackbarFail =
                            SnackBar(content: Text('Food addition failed'));

                        if (response == "success") {
                          Navigator.pushNamed(context, '/admin').then((_) {
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
                      'ADD',
                      style: TextStyle(fontSize: 14, letterSpacing: 0.3),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  TextFormField nameField() {
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
