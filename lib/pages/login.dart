// ignore_for_file: unnecessary_string_escapes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/components/user_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 10),
            //logo
            Image.asset(
              'lib/images/hostel.png',
              height: 150,
            ),

            SizedBox(height: 20),
            //app name
            Text(
              'HostelEase',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
              ),
            ),
            const SizedBox(height: 20),

            //user class
            Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                UserButton(
                  buttonText: "Student",
                ),
                UserButton(buttonText: "Warden")
              ],
            ),  

            const SizedBox(
              height: 10,
            ),

            //user name text field
            MyTextField(
              controller: usernameController,
              hintText: "username",
              obscureText: false,
            ),
            const SizedBox(
              height: 25,
            ),
            //password
            MyTextField(
              controller: passwordController,
              hintText: "password",
              obscureText: true,
            ),
            const SizedBox(height: 25),

            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("forgot password",
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 25),
            //login
            MyButton(onTap: signUserIn),
          ]),
        ),
      ),
    );
  }
}
