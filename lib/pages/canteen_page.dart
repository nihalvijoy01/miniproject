import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';

import '../components/canteen_button.dart';

class MyCanteen extends StatefulWidget {
  const MyCanteen({super.key});

  @override
  State<MyCanteen> createState() => _MyCanteenState();
}

class _MyCanteenState extends State<MyCanteen> {
  String? selectedDay;
  List<String> daysOfWeek = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ]; // Days of the week
  Map<String, dynamic> menuData =
      {}; // Placeholder for menu data, will be updated based on selected day

  Future<void> _getMenuByDay() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Canteen')
          .doc(selectedDay)
          .get();
      if (snapshot.exists) {
        setState(() {
          menuData = snapshot.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          menuData =
              {}; // Reset menu data if no menu found for the selected day
        });
      }
    } catch (error) {
      print('Error retrieving menu: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      appBar: AppBar(
        title: Text('Canteen Menu'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Day:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedDay,
              items: daysOfWeek.map((String day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedDay = value;
                  menuData = {}; // Reset menu data when selecting a new day
                  _getMenuByDay();
                });
              },
              decoration: InputDecoration(
                hintText: 'Select a day',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Menu for $selectedDay:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            if (menuData.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Morning Menu: ${menuData['morning'] ?? ''}',
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Noon Menu: ${menuData['noon'] ?? ''}',
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Night Menu: ${menuData['night'] ?? ''}',
                  ),
                ],
              ),
            if (menuData.isEmpty)
              Text(
                'No menu available for $selectedDay',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
