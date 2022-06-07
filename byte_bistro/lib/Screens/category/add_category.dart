import 'package:byte_bistro/Services/category_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class AddCategory extends StatelessWidget {
  AddCategory({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    CategoryController categoryController = Get.find();

    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Category',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
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
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  Map<String, String> data = {"name": nameController.text};

                  categoryController.addNewCategory(data);
                }
              },
              child: Text('ADD', style: Theme.of(context).textTheme.headline2),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(80, 40),
                primary: kPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
