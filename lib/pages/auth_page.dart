import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/student_homepage.dart';
import 'package:flutter_application_1/pages/warden_home.dart';
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? role;

  @override
  void initState() {
    super.initState();
    getRole();
  }

  Future<void> getRole() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? docId = user?.uid;
    if (docId != null) {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(docId).get();
      if (snapshot.exists) {
        setState(() {
          role = snapshot['role'];
        });
      }
    }
    print(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            if (role == 'warden') {
              return WardenHome();
            } else if (role == 'student') {
              return MyStudentHome();
            }
          }

          // User is not logged in
          return LoginPage();
        },
      ),
    );
  }
}
