import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_circle.dart';
import 'package:flutter_application_1/components/my_square.dart';

class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

final daysOfWeek = [
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday',
  'saturday',
  'sunday',
];
final timeOfDay = ['morning', 'noon', 'night'];

class _MyListViewState extends State<MyListView> {
  late String selectedDay;
  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDay = daysOfWeek[time.weekday - 1];
    print(selectedDay);
  }

  void onDaySelected(String day) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffade8f4),
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(20)),
        height: 300,
        child: Column(
          children: [
            // Days of week
            Container(
              height: 60,
              child: ListView.builder(
                itemCount: daysOfWeek.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MyCircle(
                    child: daysOfWeek[index],
                    isSelected: daysOfWeek[index] == selectedDay,
                    onTap: () => onDaySelected(daysOfWeek[index]),
                  );
                },
              ),
            ),
            // Time of day
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: timeOfDay.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MySquare(
                      child: timeOfDay[index], selectedDay: selectedDay);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
