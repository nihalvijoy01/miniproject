import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/dropdown_button.dart';

class WardenAttendence extends StatefulWidget {
  const WardenAttendence({super.key});

  @override
  State<WardenAttendence> createState() => _WardenAttendenceState();
}

class _WardenAttendenceState extends State<WardenAttendence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Attendence",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            DropDownButton(),
          ],
        ),
      )),
    );
  }
}
