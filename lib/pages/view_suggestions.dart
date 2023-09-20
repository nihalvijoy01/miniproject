import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/base_layout.dart';

class ViewMenuSuggestion extends StatelessWidget {
  ViewMenuSuggestion({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Suggestions',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xffade8f4),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('MenuSuggestions').snapshots(),
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
                final String day = document['day'];
                final String time = document['time'];
                final String suggestion = document['suggestion'];

                return ListTile(
                  title: Text(day),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(time),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion,
                            style: TextStyle(color: Colors.black),
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
      ),
    );
  }
}
