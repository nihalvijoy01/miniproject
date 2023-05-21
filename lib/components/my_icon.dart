import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/canteen_page.dart';

class MyIcon extends StatelessWidget {
  final String img;
  final String iconText;

  const MyIcon({
    super.key,
    required this.img,
    required this.iconText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCanteen()));
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
