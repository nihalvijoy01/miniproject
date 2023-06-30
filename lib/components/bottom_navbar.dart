import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/student_homepage.dart';
import 'package:flutter_application_1/pages/view_profile.dart';

import '../pages/login.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyStudentHome()));
    }
    if (currentIndex == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewProfile()));
    }
    if (currentIndex == 2) {
      signUserOut(context);
    }
  }

  //sign user out method
  Future<void> signUserOut(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xffade8f4),
          selectedItemColor: Colors.black,
          //selectedItemColor: Colors.red,
          //unselectedItemColor: Colors.black,
          currentIndex: currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_rounded),
              label: 'Logout',
            )
          ]),
    );
  }
}
