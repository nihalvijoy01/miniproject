import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/components/my_icon.dart';
import 'package:flutter_application_1/pages/canteen_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
      ]),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          //icon 1

          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              MyIcon(
                img: 'lib/images/canteen.png',
                iconText: 'canteen',
              ),

              const SizedBox(
                height: 10,
                width: 50,
              ),

              //icon 2
              MyIcon(
                img: 'lib/images/complain.png',
                iconText: 'complaints',
              ),
            ],
          ),

          //icon 3

          //icon 4

          Text("logged in"),
        ],
      )),
    );
  }
}
