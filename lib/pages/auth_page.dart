import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_radiobutton.dart';
import 'package:flutter_application_1/pages/login.dart';

import 'home_page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({required this.userType, super.key});
  UserType? userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData && userType == UserType.Student) {
            return HomePage();
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
