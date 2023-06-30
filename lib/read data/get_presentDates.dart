import 'package:cloud_firestore/cloud_firestore.dart';

class GetAttendance{
  static Stream<QuerySnapshot> getComplaintsStream(String studentId) {
    return FirebaseFirestore.instance
        .collection('Student')
        .doc(studentId)
        .collection('Attendance')
        .snapshots();
}}
