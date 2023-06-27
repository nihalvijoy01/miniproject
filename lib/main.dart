import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/db_listview.dart';
import 'package:flutter_application_1/components/my_radiobutton.dart';
import 'package:flutter_application_1/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/student_homepage.dart';
import 'firebase_options.dart';

UserType? userType;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
