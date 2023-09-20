import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/add_students.dart';
import 'package:flutter_application_1/pages/view_suggestions.dart';
import 'package:flutter_application_1/pages/warden_cleaning.dart';
import 'package:flutter_application_1/pages/warden_complaint.dart';

import '../pages/login.dart';

class WardenDrawer extends StatelessWidget {
  WardenDrawer({super.key});
  final style = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  Future<void> signUserOut(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: Color(0xffcaf0f8),
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xff41e2fb)),
                  child: const Center(
                      child: Text(
                    'H O S T E L  E A S E',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ))),
              ListTile(
                leading: Icon(Icons.report),
                title: Text(
                  "Complaints",
                  style: style,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewComplaintsPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.cleaning_services),
                title: Text(
                  "Cleaning",
                  style: style,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WardenCleaning()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.password_outlined),
              //   title: Text(
              //     "Change Password",
              //     style: style,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ChangePasswordPage()));
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Add Students",
                  style: style,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddStudents()));
                },
              ),
              ListTile(
                leading: Icon(Icons.menu),
                title: Text(
                  "Menu Suggestion",
                  style: style,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewMenuSuggestion()));
                },
              ),
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Logout",
                    style: style,
                  ),
                  onTap: () => signUserOut(context)),
            ],
          )),
    );
  }
}
