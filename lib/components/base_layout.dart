import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("lib/images/grey_bg.jpg"), fit: BoxFit.cover),
      ),
      child: Center(child: child),
    );
  }
}
