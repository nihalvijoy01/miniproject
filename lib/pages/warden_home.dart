import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/pages/login.dart';

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
        bottomNavigationBar: BottomNav(),
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Warden Dashboard",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
                IconButton(
                    onPressed: () => signUserOut(context),
                    icon: Icon(Icons.logout)),
              ],
            ),
            SizedBox(
              height: 80,
              width: 10,
            ),
            //icon 1

            Row(
              children: const [
                SizedBox(height: 10, width: 40),
                MyIcon(
                  user: 'Warden',
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
                  user: 'Warden',
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
                  height: 30,
                  width: 40,
                ),
                MyIcon(
                    user: 'Warden',
                    id: "3",
                    img: 'lib/images/oosouji.png',
                    iconText: 'cleaning'),
                const SizedBox(
                  height: 10,
                  width: 100,
                ),

                //icon 4
                MyIcon(
                    user: 'Warden',
                    id: "4",
                    img: 'lib/images/calendar.png',
                    iconText: 'attendence'),

                //icon 5
              ],
            ),
            Row(
              children: [
                MyIcon(
                    img: 'lib/images/complain.png',
                    iconText: 'add students',
                    id: '5',
                    user: 'Warden')
              ],
            )
          ],
        )),
      ),
    );
  }
}
