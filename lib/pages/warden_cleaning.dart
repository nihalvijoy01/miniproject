import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/read%20data/get_cleaning.dart';

class WardenCleaning extends StatefulWidget {
  const WardenCleaning({super.key});

  @override
  State<WardenCleaning> createState() => _WardenCleaningState();
}

class _WardenCleaningState extends State<WardenCleaning> {
  void updateActiveStatus(String studentId, String complaintId, bool isActive) {
    FirebaseFirestore.instance
        .collection('Student')
        .doc(studentId)
        .collection('CleaningOrders')
        .doc(complaintId)
        .update({'active_status': !isActive});
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('View Cleaning Orders'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Student').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.data!.docs.isEmpty) {
              return Text('No students found.');
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                final studentId = document.id;
                final studentData = document.data() as Map<String, dynamic>;
                final roomNumber = studentData['room'];

                return StreamBuilder<QuerySnapshot>(
                  stream: GetCleaning.GetCleaningStream(studentId),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> cleaningSnapshot) {
                    if (cleaningSnapshot.hasError) {
                      return Text('Error: ${cleaningSnapshot.error}');
                    }

                    if (cleaningSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (cleaningSnapshot.data!.docs.isEmpty) {
                      return SizedBox
                          .shrink(); // Skip rendering if no complaints for the student
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Room Number: $roomNumber',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: cleaningSnapshot.data!.docs
                                .map((DocumentSnapshot cleaningDoc) {
                              final cleaningData =
                                  cleaningDoc.data() as Map<String, dynamic>;
                              final instructions =
                                  cleaningData['instructions'] ?? '';
                              final isActive =
                                  cleaningData['active_status'] ?? false;

                              String activeStatusText =
                                  isActive ? 'In Progress' : 'Closed';

                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(instructions),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                isActive
                                                    ? Colors.green
                                                    : Colors.red),
                                      ),
                                      onPressed: () {
                                        updateActiveStatus(studentId,
                                            cleaningDoc.id, isActive);
                                      },
                                      child: Text(isActive
                                          ? 'Close order'
                                          : 'Reopen order'),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Divider(), // Add a divider between students
                      ],
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
