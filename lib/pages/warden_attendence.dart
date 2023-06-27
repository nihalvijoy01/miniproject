import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/components/my_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class WardenAttendence extends StatefulWidget {
  const WardenAttendence({super.key});

  @override
  State<WardenAttendence> createState() => _WardenAttendenceState();
}

class _WardenAttendenceState extends State<WardenAttendence> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedRoom;
  List<String> studentNames = [];
  TextStyle _textstyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final TextEditingController dateController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   getStudentNames();
  // }

  //date time varaible

  DateTime _dateTime = DateTime.now();
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "${_dateTime}"; //set the initial value of text field
    super.initState();
  }


  List<bool> isPresent =
      List.generate(4, (index) => false); // Initialize isPresent list

  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

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

  // void datePicker() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(2020),
  //           lastDate: DateTime(2025))
  //       .then((value) {
  //     setState(() {
  //       _dateTime = value!;
  //     });
  //   });
  // }

  void _submitAttendance() {
    // Here you can handle the submission of attendance data
    print('Attendance submitted');
    print('Date: $_dateTime');
    print('Room: $selectedRoom');
    print('Attendance: $isPresent');
    
    _refreshPage();
  }

  Future<void> _refreshPage() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating a delay
    refreshKey.currentState?.show(atTop: false);
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WardenAttendence()));
    }); // Refresh the page by calling setState
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
            TextField(
              controller: dateInput,
              //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date" //label text of field
                  ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
            
            Text('${_dateTime.day}-${_dateTime.month}-${_dateTime.year}'),
            SizedBox(
              width: 30,
            ),
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
              style: _textstyle,
            ),
            SizedBox(height: 10),
            Container(
              height: 400,
              child: ListView.builder(
                itemCount: studentNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(studentNames[index]),
                        Checkbox(
                            value: isPresent[index],
                            onChanged: (newbool) {
                              setState(() {
                                isPresent[index] = newbool!;
                              });
                            })
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            MyButton(onTap: _submitAttendance, text: "Submit")
          ],
        ),
      ),
    );
  }
}
