import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/date_picker.dart';

import '../components/my_button.dart';

class MarkAttendence extends StatefulWidget {
  const MarkAttendence({super.key});

  @override
  State<MarkAttendence> createState() => _MarkAttendenceState();
}

class _MarkAttendenceState extends State<MarkAttendence> {
  TextEditingController datecontroller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  //list of rooms
  List<String> rooms = ['100', '101', '102', '103', '104'];

  List<String> studentNames = [];

  String? selectedRoom;

  List<bool> isPresent = List.generate(3, (index) => false);

  //get student names according to their rooms
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

  //refresh page
  // void _refreshPage() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => MarkAttendence()));
  // }

  //submit attedance method
  Future<void> _submitAttendance() async {
    print('Attendance submitted');
    print('Date: $datecontroller');
    print('Room: $selectedRoom');
    print("students: $studentNames");
    print('Attendance: $isPresent');

    for (var i = 0; i < studentNames.length; i++) {
      String student_docid = '';
      final Attendance = <String, dynamic>{
        "isPresent": isPresent[i],
        "date": datecontroller.text,
      };
      await firestore
          .collection("Student")
          .where("name", isEqualTo: studentNames[i])
          .get()
          .then(
        (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
            student_docid = docSnapshot.id;
            print(student_docid);
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
      await firestore
          .collection("Student")
          .doc(student_docid)
          .collection("Attendance")
          .doc()
          .set(Attendance);
      // _refreshPage();
    }
  }

  //form key
  final formKey = GlobalKey<FormState>();

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mark Attendance")),
      body: Form(
        key: formKey,
        child: Column(children: [
          DatePicker(controller: datecontroller),
          const SizedBox(
            height: 30,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                color: Color(0xffcaf0f8),
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(50),
                boxShadow: <BoxShadow>[
                  //apply shadow on Dropdown button
                  BoxShadow(
                      color: Color.fromARGB(
                          255, 158, 189, 243), //shadow for button
                      blurRadius: 5)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: DropdownButton<String>(
                value: selectedRoom,

                hint: Text('Select a room'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRoom = newValue!;
                    getStudentNames(selectedRoom!);
                  });
                },
                items: rooms.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                dropdownColor: Color(0xffcaf0f8),
                underline: Container(), //remove underline
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Student Names:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.grey[200],
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: studentNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(studentNames[index]),
                      SizedBox(width: 50),
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
          SizedBox(height: 30),
          MyButton(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  _submitAttendance();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Attendance Submitted"),
                    ),
                  );
                  formKey.currentState!.save();
                }
              },
              text: "Submit")
              
        ]),
      ),
    );
  }
}
