import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';

import 'package:table_calendar/table_calendar.dart';

class MyAttendence extends StatefulWidget {
  const MyAttendence({super.key});

  @override
  State<MyAttendence> createState() => _MyAttendenceState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
//get current user id
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? docid = user?.uid;
List<DateTime> dates1 = [];
List<String> dates = [];

class _MyAttendenceState extends State<MyAttendence> {
  Future<void> getAttendance() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('Student')
          .doc(docid)
          .collection('Attendance')
          .get();
      List<String> names = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['date'] as String)
          .toList();

      setState(() {
        dates = names;
      });
    } catch (e) {
      print('Error retrieving attendance: $e');
    }
  }

  void initState() {
    getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < dates.length; i++) {
      dates1.add(DateTime.parse(dates[i]));
    }
    print(dates1);

    DateTime today = DateTime.now();
    return BaseLayout(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Attendence Calender",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color(0xffade8f4),
          ),
          body: Column(
            children: [
              TableCalendar(
                focusedDay: today,
                firstDay: DateTime.utc(2020, 01, 01),
                lastDay: DateTime.utc(2024, 12, 30),
                calendarBuilders: CalendarBuilders(
                  // Mark the dates in 'dates1' with green background color
                  markerBuilder: (context, day, events) {
                    for (DateTime d in dates1) {
                      if (day.day == d.day &&
                          day.month == d.month &&
                          day.year == d.year) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// if (dates1.contains(date)) {
//                 return Container(
//                   margin: const EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.green,
//                   ),
//                 );
//               }