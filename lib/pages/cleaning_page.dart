import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;
final mycontroller = TextEditingController();

class MyCleaning extends StatelessWidget {
  const MyCleaning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Cleaning')),
      body: Padding(
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
                        borderSide: BorderSide(color: Colors.red))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  print(mycontroller.text);
                  final cleaning = <String, dynamic>{
                    "instructions": mycontroller.text,
                  };
                  db.collection("CleaningOrders").add(cleaning).then(
                      (DocumentReference doc) =>
                          print('DocumentSnapshot added with ID: ${doc.id}'));
                },
                child: const Text("Place Order"))
          ],
        ),
      ),
    );
  }
}
