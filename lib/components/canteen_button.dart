import 'package:flutter/material.dart';

class cantButton extends StatelessWidget {
  final String buttonText;
  const cantButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ));
  }
}
