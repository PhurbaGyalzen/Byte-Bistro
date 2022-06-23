import 'package:flutter/material.dart';

class TestingExpanded extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        body: Column(children: [
          Text("hello"),
          Expanded(child: SizedBox()),
          Text("hi")
        ],)
      ),
    );
  }
}
