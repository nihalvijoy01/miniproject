import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/read%20data/get_cleaning.dart';

class WardenCleaning extends StatefulWidget {
  const WardenCleaning({super.key});

  @override
  State<WardenCleaning> createState() => _WardenCleaningState();
}

class _WardenCleaningState extends State<WardenCleaning> {

   List<String> docIDs = [];

  //get docIds

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("CleaningOrders")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Cleaning Oders",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              SizedBox(
                height: 40,
              ),
              Expanded(
                  child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: GetCleaning(documentId: docIDs[index]),
                            tileColor: Colors.grey[300],
                          ),
                        );
                      });
                },
              )),
            ],
          ),
        ),
      ),

    );
  }
}