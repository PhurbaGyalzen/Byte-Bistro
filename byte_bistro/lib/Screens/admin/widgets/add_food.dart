import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 30,
                bottom: 30,
              ),
              child: Text(
                'Add Food',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  wordSpacing: 0.5,
                ),
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
            descriptionField(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimary,
                    onPrimary: kTextColor,
                  ),
                  onPressed: () {
                    print(nameController.text);
                    print(priceController.text);
                    print(descriptionController.text);
                  },
                  child: Text(
                    'Add Food',
                    style: TextStyle(fontSize: 18, letterSpacing: 0.3),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () => dismissDialog(),
                  child: Text(
                    'Close',
                    style: TextStyle(fontSize: 18, letterSpacing: 0.3),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
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

  dismissDialog() {
    Navigator.pop(context);
  }
}
