import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/canteen_page.dart';

import '../pages/complaint_page.dart';

class MyIcon extends StatelessWidget {
  final String img;
  final String iconText;
  final String id;

  const MyIcon({
    super.key,
    required this.img,
    required this.iconText,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            if (id == "1") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyCanteen()));
            }
            if (id == "2") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyComplaints()));
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
