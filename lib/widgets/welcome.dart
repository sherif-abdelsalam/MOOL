import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = TextStyle(
      fontSize: 32,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        SizedBox(height: 32),
        Image.asset("images/welcome.png"),
        SizedBox(height: 24),
        Column(
          children: [
            Text(
              "Find the ",
              style: theme,
            ),
            Text("best Collection", style: theme),
          ],
        ),
      ],
    );
  }
}
