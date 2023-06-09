import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';

final _formKey = GlobalKey<FormState>();
final db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class MyComplaints extends StatelessWidget {
  MyComplaints({super.key});

  String? compSub;
  String? compDesc;
  bool active_status = true;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Text(
                      "Complaints Page",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Subject'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'subject must be entered';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        compSub = value;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 300,
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Complaint details',
                            enabledBorder: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'subject must be entered';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          compDesc = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //submitt button
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Complaint Registered"),
                            ),
                          );
                        }
                        _formKey.currentState!.save();
                        //get user id
                        final User? user = auth.currentUser;
                        final String? docid = user?.uid;

                        final complaint = <String, dynamic>{
                          "Subject": compSub,
                          "description": compDesc,
                          "active_status": active_status
                        };
                        // db.collection("Complaints").add(complaint).then(
                        //     (DocumentReference doc) => print(
                        //         'DocumentSnapshot added with ID: ${doc.id}'));
                        db
                            .collection('Student')
                            .doc(docid)
                            .collection('Complaints')
                            .doc()
                            .set(complaint);
                      },
                      child: const Text("submit"),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
