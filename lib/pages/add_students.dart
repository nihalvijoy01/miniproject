import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  //text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roomController = TextEditingController();
  final passwordController = TextEditingController();

  //signup student
  void signUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try adding the user
    try {
      final User? warden = FirebaseAuth.instance.currentUser;
      print(warden?.uid);
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(warden?.uid)
              .get();
      dynamic fieldValue = userSnapshot.get('hostel');
      print(fieldValue);
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      final User? user = userCredential.user;
      print(user?.uid);
      final student_users = <String, String>{
        "name": nameController.text,
        "role": "student",
        "hostel": fieldValue
      };
      final student = <String, String>{
        "name": nameController.text,
        "email": emailController.text,
        "room": roomController.text
      };

      if (user != null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set(student_users);
        FirebaseFirestore.instance
            .collection("Student")
            .doc(user.uid)
            .set(student);
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('SignUp Failed'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Column(
        children: [
          const Text(
            "SIGN UP STUDENTS",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
              controller: nameController, hintText: 'name', obscureText: false),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
              controller: emailController,
              hintText: 'email',
              obscureText: false),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
              controller: roomController,
              hintText: 'room no',
              obscureText: false),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
              controller: passwordController,
              hintText: 'password',
              obscureText: true),
          const SizedBox(
            height: 30,
          ),
          MyButton(text: "Add Student", onTap: signUp)
        ],
      )),
    ));
  }
}
