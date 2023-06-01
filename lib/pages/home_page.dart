import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';

import 'package:flutter_application_1/components/my_icon.dart';
import 'package:flutter_application_1/pages/canteen_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
              child: Column(

            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Student Dashboard!",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 30, color: Colors.black87,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
                ],
              ),
              SizedBox(
                height: 80,
              ),
              //icon 1

              Row(
                children: const [
                  SizedBox(
                    height: 10,
                    width: 40,
                  ),
                  MyIcon(
                    user: 'Student',
                    id: "1",
                    img: 'lib/images/canteen(1).png',
                    iconText: 'canteen',
                  ),

                  SizedBox(
                    height: 10,
                    width: 100,
                  ),

                  //icon 2
                  MyIcon(
                    user: 'Student',
                    id: "2",
                    img: 'lib/images/complain (2).png',
                    iconText: 'complaints',
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              //icon 3
 
              Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  MyIcon(
                      user: 'Student',
                      id: "3",
                      img: 'lib/images/oosouji.png',
                      iconText: 'cleaning'),
                  const SizedBox(
                    height: 10,
                    width: 100,
                  ),

                  //icon 4
                  MyIcon(
                      user: 'Student',
                      id: "4",
                      img: 'lib/images/calendar.png',
                      iconText: 'attendence'),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}

// 