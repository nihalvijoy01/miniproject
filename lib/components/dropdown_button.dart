import 'package:flutter/material.dart';

String? chosenValue;

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: chosenValue,
          //elevation: 5,
          style: TextStyle(color: Colors.black),

          items: <String>[
            '305',
            '306',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text(
            "Please choose a room",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onChanged: (String? value) {
            setState(() {
              chosenValue = value!;
            });
          },
        ), 
      ],
    );
  }
}
