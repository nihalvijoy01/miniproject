import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:table_calendar/table_calendar.dart';

class MyAttendence extends StatelessWidget {
  const MyAttendence({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return BaseLayout(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Attendence Calender"),
            backgroundColor: Colors.transparent,
          ),
          body: TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2020, 01, 01),
              lastDay: DateTime.utc(2024, 12, 30)),
        ),
      ),
    );
  }
}
