import 'package:flutter/material.dart';


class MyCanteen extends StatelessWidget {
  const MyCanteen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canteen page'),
      actions: [IconButton(onPressed:(){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back))]),
    );
  }
}