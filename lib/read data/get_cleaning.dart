import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetCleaning extends StatelessWidget {
  const GetCleaning({required this.documentId, super.key});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference cleaning =
        FirebaseFirestore.instance.collection('CleaningOrders');

    return FutureBuilder<DocumentSnapshot>(
      future: cleaning.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('instructions: ${data['instructions']}');
        }
        return (Text('Loading'));
      },
    );
  }
}
