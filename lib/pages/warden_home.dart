import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/base_layout.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';

import '../components/my_icon.dart';

class WardenHome extends StatelessWidget {
  const WardenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Warden Dashboard",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            SizedBox(
              height: 30,
              width: 10,
            ),
            //icon 1

            Row(
              children: const [
                SizedBox(
                  height: 10,
                ),
                MyIcon(
                  user: 'Warden',
                  id: "1",
                  img: 'lib/images/canteen.png',
                  iconText: 'canteen',
                ),

                SizedBox(
                  height: 10,
                  width: 100,
                ),

                //icon 2
                MyIcon(
                  user: 'Warden',
                  id: "2",
                  img: 'lib/images/complain.png',
                  iconText: 'complaints',
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            //icon 3

            Row(
              children: [
                MyIcon(
                    user: 'Warden',
                    id: "3",
                    img: 'lib/images/cleaning.png',
                    iconText: 'cleaning'),
                const SizedBox(
                  height: 10,
                  width: 100,
                ),

                //icon 4
                MyIcon(
                    user: 'Warden',
                    id: "4",
                    img: 'lib/images/immigration.png',
                    iconText: 'attendence'),
              ],
            )
          ],
        )),
      ),
    );
  }
}
