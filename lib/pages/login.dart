// ignore_for_file: unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/my_button.dart';

import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/components/user_button.dart';
import 'package:flutter_application_1/pages/auth_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/warden_home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String? selectedHostel;

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: '$username@gmail.com',
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        final DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          final String role = snapshot['role'];
          final String hostel = snapshot['hostel'];

          if (role == 'student' && hostel == selectedHostel) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (role == 'warden' && hostel == selectedHostel) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WardenHome()),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        _errorMessage = 'Invalid username or password.';
      } else {
        _errorMessage = 'An error occurred. Please try again later.';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text(_errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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

                    // Row(children: [
                    //   MyRadioButton(
                    //       title: UserType.Student.name,
                    //       value: UserType.Student,
                    //       selectedUserType: _userType,
                    //       onChanged: (val) {
                    //         setState(() {
                    //           _userType = val;
                    //         });
                    //       }),
                    //   SizedBox(
                    //     width: 10,
                    //   ),
                    //   MyRadioButton(
                    //       title: UserType.Warden.name,
                    //       value: UserType.Warden,
                    //       selectedUserType: _userType,
                    //       onChanged: (val) {
                    //         setState(() {
                    //           _userType = val;
                    //         });
                    //       })
                    // ]),

                    const SizedBox(
                      height: 10,
                    ),

                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: <BoxShadow>[
                            //apply shadow on Dropdown button
                            BoxShadow(
                                color: Color.fromARGB(
                                    255, 158, 189, 243), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: DropdownButton<String>(
                          value: selectedHostel,
                          hint: Text('Select your hostel'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedHostel = newValue!;
                            });
                          },
                          items: [
                            DropdownMenuItem<String>(
                              value: 'sth',
                              child: Text('St.teresas hostel'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'stsh',
                              child: Text('St.thomas hostel'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'sjh',
                              child: Text('St.josephs hostel'),
                            ),
                          ],
                          icon: Padding(
                              //Icon at tail, arrow bottom is default icon
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(Icons.arrow_circle_down_sharp)),
                          iconEnabledColor: Colors.blueGrey, //Icon color
                          style: TextStyle(
                              //te
                              color: Colors.grey[800], //Font color
                              fontSize: 16 //font size on dropdown button
                              ),

                          dropdownColor:
                              Colors.grey[200], //dropdown background color
                          underline: Container(), //remove underline
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //user name text field
                    MyTextField(
                      controller: _usernameController,
                      hintText: "username",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //password
                    MyTextField(
                      controller: _passwordController,
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
                      text: "Login",
                      onTap: _login,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
