import 'package:flutter/material.dart';
import 'package:mool/screens/tabs.dart';
import 'package:mool/utils/button.dart';

class DoneTrans extends StatelessWidget {
  const DoneTrans({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/done_trans.gif",
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              "We Get it ! ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Your order submit successfully",
            ),
            SizedBox(height: 8),
            SizedBox(
                width: size.width * .7,
                child: Text(
                  style: TextStyle(color: Color(0xff616161)),
                  "You will get notifications for your order’s state",
                  textAlign: TextAlign.center,
                )),
            SizedBox(height: 20),
            Button(
              padding: size.width * .18,
              btnText: "Go back to home",
              onTapBtn: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => TabsScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
