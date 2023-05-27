import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class MyComplaints extends StatelessWidget {
  MyComplaints({super.key});

  String? compSub;
  String? compDesc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Subject'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'subject must be entered';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      compSub = value;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 300,
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      decoration: InputDecoration(
                          labelText: 'Complaint details',
                          enabledBorder: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'subject must be entered';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        compDesc = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //submitt button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Complaint Registered"),
                          ),
                        );
                      }
                      _formKey.currentState!.save();
                      print(compSub);
                      print(compDesc);
                    },
                    child: const Text("submit"),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
