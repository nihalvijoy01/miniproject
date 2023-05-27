import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/attendence.dart';
import 'package:flutter_application_1/pages/canteen_page.dart';
import 'package:flutter_application_1/pages/cleaning_page.dart';
import 'package:flutter_application_1/pages/warden_attendence.dart';
import 'package:flutter_application_1/pages/warden_complaint.dart';

import '../pages/complaint_page.dart';

class MyIcon extends StatelessWidget {
  final String img;
  final String iconText;
  final String id;
  final String user;

  const MyIcon(
      {super.key,
      required this.img,
      required this.iconText,
      required this.id,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            if (user == 'Student') {
              if (id == "1") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCanteen()));
              }
              if (id == "2") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyComplaints()));
              }
              if (id == '3') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCleaning()));
              }
              if (id == '4') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAttendence()));
              }
            }
            if (user == 'Warden') {
              if (id == '2') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WardenComplaints()));
              }
              if (id == '4') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WardenAttendence()));
              }
            }
          },
          splashColor: Colors.black26,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ink.image(
                  image: AssetImage(img),
                  height: 72,
                  width: 72,
                  fit: BoxFit.cover),
              const SizedBox(
                height: 6,
              ),
              Text(iconText),
            ],
          ),
        ),
      ),
    );
  }
}
