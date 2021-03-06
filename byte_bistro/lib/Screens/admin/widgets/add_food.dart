import 'dart:io';

import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:byte_bistro/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  var imageName = "";
  late File? pickedImage;
  List categoryToSent = [];

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    priceController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  Future<void> pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
        imageName = tempImage.path.split("/").last;
      });
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FoodController foodController = Get.put(FoodController());
    CategoryController categoryController = Get.find();

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
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
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
              SizedBox(
                height: 20,
              ),
              priceField(),
              SizedBox(
                height: 20,
              ),
              MultiSelectDialogField(
                initialValue: categoryController.selectedCategory,
                listType: MultiSelectListType.CHIP,
                chipDisplay: MultiSelectChipDisplay.none(),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.food_bank_rounded,
                  color: Colors.black,
                ),
                buttonText: Text(
                  "Select Categories",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                items: categoryController.categoryList
                    .map((categories) =>
                        MultiSelectItem(categories, categories.name))
                    .toList(),
                title: Text("Categories"),
                selectedColor: Colors.black,
                selectedItemsTextStyle: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    fontWeight: FontWeight.bold),
                searchable: true,
                onConfirm: (results) {
                  categoryController.selectedCategory = results;
                  categoryController.selectedCategoryValue.value = "";
                  categoryController.selectedCategory.forEach((element) {
                    categoryController.selectedCategoryValue.value =
                        categoryController.selectedCategoryValue.value +
                            " " +
                            element.name;
                    categoryToSent.add("${element.id}");
                    print(categoryToSent);
                  });
                },
              ),
              Obx(() => Text(categoryController.selectedCategoryValue.value)),
              SizedBox(
                height: 20,
              ),
              Text(
                imageName,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimary)),
                  onPressed: () {
                    Get.bottomSheet(
                      SingleChildScrollView(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: Container(
                            color: Colors.black,
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Upload food Image from:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimary, // Background color
                                    ),
                                    onPressed: () {
                                      pickImage(ImageSource.camera);
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text("CAMERA"),
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimary, // Background color
                                    ),
                                    onPressed: () {
                                      pickImage(ImageSource.gallery);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text("GALLERY"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimary, // Background color
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.close),
                                    label: const Text("CANCEL"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Pick a Image',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  )),
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
                        Map<String, dynamic> data = {
                          "name": nameController.text,
                          "price": priceController.text,
                          "image": pickedImage,
                          "description": descriptionController.text,
                          "categories": categoryToSent,
                        };

                        String response = await foodController.addFood(data);

                        if (response == "success") {
                          categoryController.selectedCategory = [];
                          categoryController.selectedCategoryValue.value = " ";
                          Navigator.pushNamed(context, '/adminScreen')
                              .then((_) {
                            // This block runs when you have returned back to the 1st Page from 2nd.
                            setState(() {
                              // Call setState to refresh the page.
                            });
                          });

                          Get.snackbar(
                            "Add",
                            "Food added successfully",
                            icon: Icon(Icons.no_meals, color: Colors.white),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            animationDuration: Duration(seconds: 1),
                            dismissDirection: DismissDirection.horizontal,
                            snackPosition: SnackPosition.TOP,
                          );
                          foodController.getAllFood();
                        } 
                      }
                    },
                    child: Text(
                      'ADD',
                      style: Theme.of(context).textTheme.headline2,
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
