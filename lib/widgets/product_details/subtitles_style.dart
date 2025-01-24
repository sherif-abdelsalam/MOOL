import 'package:flutter/material.dart';

class SubtitlesStyle extends StatelessWidget {
  const SubtitlesStyle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0XFF181818),
      ),
    );
  }
}
