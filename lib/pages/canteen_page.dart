import 'package:flutter/material.dart';

import '../components/canteen_button.dart';

class MyCanteen extends StatelessWidget {
  const MyCanteen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      appBar: AppBar(
        title: Text('Canteen page'),
        foregroundColor: Colors.orange,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),

              //sunday

              cantButton(buttonText: "Sunday"),
              const SizedBox(
                height: 50,
              ),

              //monday

              cantButton(buttonText: "Monday"),
              const SizedBox(
                height: 50,
              ),

              //tuesday
              cantButton(buttonText: "Tuesday"),
              const SizedBox(
                height: 50,
              ),

              //wednesday
              cantButton(buttonText: "Wednesday"),
              const SizedBox(
                height: 50,
              ),

              //thursday
              cantButton(buttonText: "Thursday"),
              const SizedBox(
                height: 50,
              ),

              //friday
              const cantButton(buttonText: "Friday"),
              const SizedBox(
                height: 50,
              ),

              //saturday
              cantButton(buttonText: "Saturday"),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
