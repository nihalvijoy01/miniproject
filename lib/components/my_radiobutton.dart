import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';

enum UserType { Student, Warden }

class MyRadioButton extends StatelessWidget {
  MyRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.selectedUserType,
      required this.onChanged});

  String title;
  UserType value;
  UserType? selectedUserType;
  Function(UserType?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<UserType>(
          value: value,
          groupValue: selectedUserType,
          title: Text(title),
          tileColor: Colors.black12,
          dense: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          onChanged: onChanged),
    );
  }
}
