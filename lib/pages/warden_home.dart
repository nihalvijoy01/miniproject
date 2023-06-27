import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/pages/login.dart';

import '../components/db_listview.dart';
import '../components/my_icon.dart';

class WardenHome extends StatelessWidget {
  const WardenHome({super.key});

  Future<void> signUserOut(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Warden dashboard"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyListView(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent),
                        child: MyIcon(
                          user: 'Warden',
                          id: "1",
                          img: 'lib/images/canteen(1).png',
                          iconText: 'canteen',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.transparent,
                          child: MyIcon(
                            user: 'Warden',
                            id: "2",
                            img: 'lib/images/complain (2).png',
                            iconText: 'complaints',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.transparent,
                          child: MyIcon(
                              user: 'Warden',
                              id: "3",
                              img: 'lib/images/oosouji.png',
                              iconText: 'cleaning')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.transparent,
                        child: MyIcon(
                            user: 'Warden',
                            id: "4",
                            img: 'lib/images/calendar.png',
                            iconText: 'attendence'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
