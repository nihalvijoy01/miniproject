import 'package:cloud_firestore/cloud_firestore.dart';

class GetCleaning{
  static Stream<QuerySnapshot> getComplaintsStream(String studentId) {
    return FirebaseFirestore.instance
        .collection('Student')
        .doc(studentId)
        .collection('CleaningOrders')
        .snapshots();
}}
