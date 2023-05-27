// ignore_for_file: unnecessary_string_escapes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_radiobutton.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/components/user_button.dart';
import 'package:flutter_application_1/pages/auth_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  //Usertype variable
  UserType? _userType;

  //sign user in method
  void signUserIn() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AuthPage(
          userType: _userType,
        )));
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserButton(
                      buttonText: "Student",
                    ),
                    UserButton(buttonText: "Warden")
                  ],
                ),**/
    
                    Row(children: [
                      MyRadioButton(
                          title: UserType.Student.name,
                          value: UserType.Student,
                          selectedUserType: _userType,
                          onChanged: (val) {
                            setState(() {
                              _userType = val;
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      MyRadioButton(
                          title: UserType.Warden.name,
                          value: UserType.Warden,
                          selectedUserType: _userType,
                          onChanged: (val) {
                            setState(() {
                              _userType = val;
                            });
                          })
                    ]),
    
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
                    MyButton(
                      onTap: signUserIn,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
