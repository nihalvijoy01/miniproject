import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

import '../components/my_button.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  final pwController = TextEditingController();
  final newPwController = TextEditingController();
  final confPwController = TextEditingController();
  final emailController = TextEditingController();

  void _changePassword(BuildContext context, String email,
      String currentPassword, String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);

    user?.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Changed"),
          ),
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(error),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    }).catchError((err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text(err.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                    controller: emailController,
                    hintText: 'email',
                    obscureText: false),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                    controller: pwController,
                    hintText: 'current password',
                    obscureText: false),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                    controller: newPwController,
                    hintText: 'new password',
                    obscureText: true),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                    controller: confPwController,
                    hintText: 'confirm password',
                    obscureText: true),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                    text: "Change Password",
                    onTap: () {
                      final String email = emailController.text;
                      final String password = pwController.text;
                      final String newpassword = newPwController.text;
                      final String confirmpaswword = confPwController.text;

                      if (newpassword == confirmpaswword) {
                        _changePassword(context, email, password, newpassword);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Passwords dont match'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
