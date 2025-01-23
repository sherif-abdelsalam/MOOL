import 'package:flutter/material.dart';

class OtherCollections extends StatelessWidget {
  const OtherCollections({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/accessories.png"),
            Image.asset("images/vacation_wear.png"),
          ],
        ),
      ),
    );
  }
}
