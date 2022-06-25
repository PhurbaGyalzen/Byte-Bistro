import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Get.toNamed('/profileScreen')),
          title: Text(
            'Contact Us',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: kPrimary),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Column(
              children: [
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
