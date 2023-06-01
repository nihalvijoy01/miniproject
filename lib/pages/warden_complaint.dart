import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/read%20data/get_compalints.dart';

final db = FirebaseFirestore.instance;

// String? compDesc;
// String? compSub;

// Future<String> getComplaints() async {
//   String Compsub;
//   db.collection("Complaints").get().then(
//     (querySnapshot) {
//       print("Successfully completed");
//       for (var docSnapshot in querySnapshot.docs) {
//         print('${docSnapshot.id} => ${docSnapshot.data()}');
//         Compsub = docSnapshot.get("Subject");
//       }
//     },
//     onError: (e) => print("Error completing: $e"),
//   );
//   return Compsub;
// }

class WardenComplaints extends StatefulWidget {
  const WardenComplaints({super.key});

  @override
  State<WardenComplaints> createState() => _WardenComplaintsState();
}

class _WardenComplaintsState extends State<WardenComplaints> {
  //documentIds

  List<String> docIDs = [];

  //get docIds

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("Complaints")
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
              Text("Complaints",
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
                            title: GetComplaints(documentId: docIDs[index]),
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

// class Complaints {
//   final String? compSub;
  

//   Complaints({
//     this.compSub,
//   });
  
//   factory Complaints.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options,
//   ) {
//     final data = snapshot.data();
//     return Complaints(
//       compSub: data?['Subject'],
     
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       if (compSub != null) "name": compSub,
//     };
//   }
// }

// final docRef = db.collection("cities").doc("SF");
// docRef.get().then(
//   (DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     compSub: data?['Subject'];
//   },
//   onError: (e) => print("Error getting document: $e"),
// );

// Future<String> getSpecie(String petId) async {
//     DocumentReference documentReference = Complaints.document(petId);
//     String specie;
//     await documentReference.get().then((snapshot) {
//       specie = snapshot.data['specie'].toString();
//     });
//     return specie;
//   }

