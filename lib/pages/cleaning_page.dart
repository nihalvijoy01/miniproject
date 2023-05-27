import 'package:flutter/material.dart';

class MyCleaning extends StatelessWidget {
  const MyCleaning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Cleaning')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 300,
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                    labelText: "Cleaning instructions",
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Place Order"))
          ],
        ),
      ),
    );
  }
}
