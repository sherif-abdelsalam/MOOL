import 'package:flutter/material.dart';

class SocialSign extends StatelessWidget {
  const SocialSign({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tab(
                icon: Image.asset(
              "images/google.png",
            )),
            SizedBox(width: 12),
            Tab(
                icon: Image.asset(
              "images/apple.png",
            )),
            SizedBox(width: 12),
            Tab(
                icon: Image.asset(
              "images/facebook.png",
            )),
          ],
        ),
      ],
    );
  }
}
