import 'package:flutter/material.dart';

class OtherCollections extends StatelessWidget {
  const OtherCollections({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/accessories.png",
          fit: BoxFit.cover,
        ),
        Image.asset(
          "images/vacation_wear.png",
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
