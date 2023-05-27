import 'package:flutter/material.dart';

class cantButton extends StatelessWidget {
  final String buttonText;
  const cantButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context).pop();
    }

    openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "menu",
                textAlign: TextAlign.center,
              ),
              content: Column(
                children: [
                  Row(
                    children: [
                      Text("Morning"),
                      SizedBox(
                        width: 90,
                      ),
                      Text(
                        "7:00 - 8:00",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Puutu and Kadala"),
                  Text("Tea")
                ],
              ),
              actions: [TextButton(onPressed: submit, child: const Text("OK"))],
            ));

    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              foregroundColor: Colors.black54),
          child: Text(buttonText),
          onPressed: () {
            openDialog();
          },
        ),
      ),
    );
  }
}
