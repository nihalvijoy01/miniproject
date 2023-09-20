import 'package:flutter/material.dart';

class MyCircle extends StatelessWidget {
  final String child;
  final bool isSelected;
  final VoidCallback onTap;

  MyCircle(
      {required this.child,
      required this.isSelected,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Color(0xff0077b6) : Colors.white,
          ),
          child: Center(
            child: Text(
              child.substring(0, 1),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
