import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/read%20data/get_compalints.dart';

class ViewComplaintsPage extends StatelessWidget {
  void updateActiveStatus(String studentId, String complaintId, bool isActive) {
    FirebaseFirestore.instance
        .collection('Student')
        .doc(studentId)
        .collection('Complaints')
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
          title: Text('View Complaints'),
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
                  stream: GetComplaints.getComplaintsStream(studentId),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> complaintSnapshot) {
                    if (complaintSnapshot.hasError) {
                      return Text('Error: ${complaintSnapshot.error}');
                    }

                    if (complaintSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (complaintSnapshot.data!.docs.isEmpty) {
                      return SizedBox
                          .shrink(); // Skip rendering if no complaints for the student
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Room Number: $roomNumber',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: complaintSnapshot.data!.docs
                              .map((DocumentSnapshot complaintDoc) {
                            final complaintData =
                                complaintDoc.data() as Map<String, dynamic>;
                            final complaintTitle =
                                complaintData['Subject'] ?? '';
                            final complaintDescription =
                                complaintData['description'] ?? '';
                            final isActive =
                                complaintData['active_status'] ?? false;

                            String activeStatusText =
                                isActive ? 'In Progress' : 'Closed';

                            return ListTile(
                              title: Text(complaintTitle),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(complaintDescription),
                                  SizedBox(height: 4),
                                  Text(
                                    'Active Status: $activeStatusText',
                                    style: TextStyle(
                                      color:
                                          isActive ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.black54),
                                    ),
                                    onPressed: () {
                                      updateActiveStatus(
                                          studentId, complaintDoc.id, isActive);
                                    },
                                    child: Text(isActive
                                        ? 'Close Complaint'
                                        : 'Reopen Complaint'),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
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
