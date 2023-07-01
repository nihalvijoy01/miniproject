import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/my_button.dart';

class MenuSuggestion extends StatefulWidget {
  MenuSuggestion({super.key});

  @override
  State<MenuSuggestion> createState() => _MenuSuggestionState();
}

class _MenuSuggestionState extends State<MenuSuggestion> {
  final List<String> daysOfWeek = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
  // Days of the week

  final List<String> timeofday = ['morning', 'noon', 'night'];
  // time of the day

  final TextEditingController suggcontroller = TextEditingController();
  String? selectedDay;
  String? selectedtime;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Give Suggestions",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color(0xffade8f4),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Select Day:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButtonFormField<String>(
                  items: timeofday.map((String day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedtime = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select time of day',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 300,
                  child: TextField(
                    controller: suggcontroller,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                        labelText: "Suggestions",
                        alignLabelWithHint: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26))),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                    onTap: () async {
                      final suggestion = <String, dynamic>{
                        "day": selectedDay,
                        "time": selectedtime,
                        "suggestion": suggcontroller.text
                      };
                      await FirebaseFirestore.instance
                          .collection("MenuSuggestions")
                          .doc()
                          .set(suggestion);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Suggestion Registered"),
                        ),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuSuggestion()));
                    },
                    text: 'Submit')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
