import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetComplaints extends StatelessWidget {
  const GetComplaints({required this.documentId, super.key});
  final String documentId;

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference complaints =
        FirebaseFirestore.instance.collection('Complaints');

    return FutureBuilder<DocumentSnapshot>(
      future: complaints.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('Subject: ${data['Subject']}' +
              ' , Description: ${data['description']}');
        }
        return (Text('Loading'));
      },
    );
  }
}
