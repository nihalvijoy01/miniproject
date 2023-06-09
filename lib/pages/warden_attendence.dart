import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WardenAttendence extends StatefulWidget {
  const WardenAttendence({super.key});

  @override
  State<WardenAttendence> createState() => _WardenAttendenceState();
}

class _WardenAttendenceState extends State<WardenAttendence> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedRoom;
  List<String> studentNames = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getStudentNames();
  // }

  Future<void> getStudentNames(String selectedRoom) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('Student')
          .where('room', isEqualTo: selectedRoom)
          .get();
      List<String> names = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['name'] as String)
          .toList();

      setState(() {
        studentNames = names;
      });
    } catch (e) {
      print('Error retrieving student names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedRoom,
              hint: Text('Select a room'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedRoom = newValue!;
                  getStudentNames(selectedRoom!);
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: '101',
                  child: Text('Room 1'),
                ),
                DropdownMenuItem<String>(
                  value: '102',
                  child: Text('Room 2'),
                ),
                DropdownMenuItem<String>(
                  value: '103',
                  child: Text('Room 3'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Student Names:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: studentNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(studentNames[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  String name;
  bool isPresent;

  Student({required this.name, required this.isPresent});

//   factory Student.fromFirestore(Map<String, dynamic> data) {
//     return Student(
//       name: data['name'],
//       isPresent: data['isPresent'] ?? false,
//     );
//   }
}
