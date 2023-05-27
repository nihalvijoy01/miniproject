import 'package:flutter/material.dart';

class WardenComplaints extends StatelessWidget {
  const WardenComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Complaints",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "305",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Complaint Subjer rwrefwfect"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
