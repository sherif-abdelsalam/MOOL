import 'package:flutter/material.dart';

class ProfileTextStyle extends StatelessWidget {
  const ProfileTextStyle({super.key, required this.data});

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
