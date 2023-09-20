import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MySquare extends StatelessWidget {
  MySquare({required this.selectedDay, required this.child, Key? key})
      : super(key: key);

  final String child;
  final String selectedDay;

  Future<DocumentSnapshot> _getDocumentSnapshot() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Canteen')
          .doc(selectedDay)
          .get();
      return snapshot;
    } catch (error) {
      throw Exception('Failed to get document: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff00b4d8),
        ),
        width: 400,
        child: FutureBuilder<DocumentSnapshot>(
          future: _getDocumentSnapshot(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('Document does not exist'));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;

            String fieldValue = '';

            if (child == 'morning') {
              fieldValue = data['morning'];
            } else if (child == 'noon') {
              fieldValue = data['noon'];
            } else if (child == 'night') {
              fieldValue = data['night'];
            }

            return Center(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text('${child.toUpperCase()} MENU'),
                SizedBox(
                  height: 30,
                ),
                Text(
                  fieldValue,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
