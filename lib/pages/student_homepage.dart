import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/components/db_listview.dart';
import 'package:flutter_application_1/components/drawer.dart';
import 'package:flutter_application_1/components/my_icon.dart';

class MyStudentHome extends StatefulWidget {
  const MyStudentHome({super.key});

  @override
  State<MyStudentHome> createState() => _MyStudentHomeState();
}

class _MyStudentHomeState extends State<MyStudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNav(),
      appBar: AppBar(
        backgroundColor: Color(0xffade8f4),
        title: Text(
          "student dashboard",
          style: TextStyle(color: Colors.black),
        ),
      ),
      endDrawer: MyDrawer(),
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
                        user: 'Student',
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
                          user: 'Student',
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
                            user: 'Student',
                            id: "3",
                            img: 'lib/images/oosouji.png',
                            iconText: 'cleaning')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      child: MyIcon(
                          user: 'Student',
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
    );
  }
}
