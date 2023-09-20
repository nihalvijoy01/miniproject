import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/pages/complaint_page.dart';

class ComplaintsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? currentUser = _auth.currentUser;
    final String? currentUserId = currentUser?.uid;

    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Complaints',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xffade8f4),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('Student')
              .doc(currentUserId)
              .collection('Complaints')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.docs.isEmpty) {
              return Text('No complaints found.');
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                // Extract complaint data from the document
                final String complaintTitle = document['Subject'];
                final String complaintDescription = document['description'];
                final bool active_status = document['active_status'];
                String activeStatusText =
                    active_status ? 'In Progress' : 'Closed';
                Color activeStatusColor =
                    active_status ? Colors.green : Colors.red;

                return ListTile(
                  title: Text(complaintTitle),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(complaintDescription),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            activeStatusText,
                            style: TextStyle(color: activeStatusColor),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => MyComplaints())));
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffade8f4),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
