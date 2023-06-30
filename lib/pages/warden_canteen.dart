import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';

class WardenCanteen extends StatefulWidget {
  const WardenCanteen({super.key});

  @override
  State<WardenCanteen> createState() => _WardenCanteenState();
}

class _WardenCanteenState extends State<WardenCanteen> {
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
  String morningMenu = '';
  String noonMenu = '';
  String nightMenu = '';

  Future<void> _updateMenu() async {
    try {
      await FirebaseFirestore.instance
          .collection('Canteen')
          .doc(selectedDay)
          .update({
        'morning': morningMenu,
        'noon': noonMenu,
        'night': nightMenu,
      });
      print('Menu updated successfully');
    } catch (error) {
      print('Error updating menu: $error');
    }
  }

  void _refreshPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WardenCanteen()));
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Canteen Menu Update'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Update Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Day of the Week',
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
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select a day',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Morning Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      morningMenu = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter morning menu',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Noon Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      noonMenu = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter noon menu',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Night Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      nightMenu = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter night menu',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.black),
                    ),
                    onPressed: () {
                      // Handle menu update logic here
                      print('Day: $selectedDay');
                      print('Morning Menu: $morningMenu');
                      print('Noon Menu: $noonMenu');
                      print('Night Menu: $nightMenu');
                      _updateMenu();
                      _refreshPage();
                    },
                    child: Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
