import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetComplaints extends StatelessWidget {
  const GetComplaints(
      {required this.documentId, required this.studentId, super.key});
  final String documentId;
  final String studentId;

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference complaints =
        FirebaseFirestore.instance.collection('Students').doc(studentId).collection("Complaints");

    return FutureBuilder<DocumentSnapshot>(
      future: complaints.doc(documentId).get(),
      
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print('Subject: ${data['Subject']}' +
              ' , Description: ${data['description']}');
          return Text('Subject: ${data['Subject']}' +
              ' , Description: ${data['description']}');
        }
        
        return (Text('Loading'));
        
      },
    );
  }
}
