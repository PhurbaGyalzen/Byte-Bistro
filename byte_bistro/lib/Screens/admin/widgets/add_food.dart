import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    priceController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        nameField(),
        SizedBox(
          height: 20,
        ),
        priceField(),
        SizedBox(
          height: 20,
        ),
        descriptionField(),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            print(nameController.text);
            print(priceController.text);
            print(descriptionController.text);
          },
          child: Text(
            'Add Food',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    ));
  }

  TextField nameField() {
    return TextField(
      controller: nameController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Name'),
        hintText: 'momo',
        suffixIcon: nameController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => nameController.clear(),
              ),
      ),
    );
  }

  TextField priceField() {
    return TextField(
      controller: priceController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Price'),
        hintText: 'Rs:150',
        suffixIcon: priceController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => priceController.clear(),
              ),
      ),
    );
  }

  TextField descriptionField() {
    return TextField(
      controller: descriptionController,
      minLines:
          6, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Description'),
        hintText: 'Write something here ...',
        suffixIcon: descriptionController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => descriptionController.clear(),
              ),
      ),
    );
  }
}
