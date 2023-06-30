import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Profile")),
      bottomNavigationBar: BottomNav(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Icon(
              Icons.person,
              size: 100,
            ),
               const SizedBox(
              height: 40,
            ),
            Text("Name"),
          ],
        ),
      ),
    );
  }
}
