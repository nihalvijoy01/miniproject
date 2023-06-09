import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_radiobutton.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/warden_home.dart' ;

import 'home_page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({required this.userType, super.key});
  String userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged inStudent
          if (snapshot.hasData && userType == 'warden') {
            return HomePage();
          } else if (snapshot.hasData && userType == 'student') {
            return WardenHome();
          }
          //user is not logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
