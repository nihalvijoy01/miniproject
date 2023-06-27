import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/my_button.dart';

final db = FirebaseFirestore.instance;
final mycontroller = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;

class MyCleaning extends StatelessWidget {
  MyCleaning({super.key});
  bool active_status = true;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Order Cleaning'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 300,
                    child: TextField(
                      controller: mycontroller,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                          labelText: "Cleaning instructions",
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    text: "Place Order",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Order Registered"),
                        ),
                      );
                      print(mycontroller.text);
                      final User? user = auth.currentUser;
                      final String? docid = user?.uid;
                      final cleaning = <String, dynamic>{
                        "instructions": mycontroller.text,
                        "active_status": active_status
                      };
                      // db.collection("CleaningOrders").add(cleaning).then(
                      //     (DocumentReference doc) =>
                      //         print('DocumentSnapshot added with ID: ${doc.id}'));
                      db
                          .collection('Student')
                          .doc(docid)
                          .collection('CleaningOrders')
                          .doc()
                          .set(cleaning);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
