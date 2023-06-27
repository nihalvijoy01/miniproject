import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

import '../components/my_button.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  final pwController = TextEditingController();
  final newPwController = TextEditingController();
  final confPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            const Text(
              "Change Password",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextField(
                  controller: pwController,
                  hintText: 'current password',
                  obscureText: false),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextField(
                  controller: newPwController,
                  hintText: 'new password',
                  obscureText: false),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextField(
                  controller: confPwController,
                  hintText: 'confirm password',
                  obscureText: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(text: "Change Password", onTap: () {}),
            )
          ],
        )),
      ),
    );
  }
}
