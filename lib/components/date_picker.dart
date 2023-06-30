import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final controller;
  DatePicker({required this.controller, super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  @override
  void initState() {
    widget.controller.text =
        "select date"; //set the initial value of text field
    super.initState();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Enter Date", //label text of field
        ),
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'subject must be entered';
          }
          return null;
        },

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
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(
                formattedDate); //formatted date output using intl package =>  2021-03-16
            setState(() {
              widget.controller.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {}
        },
      ),
    );
  }
}
