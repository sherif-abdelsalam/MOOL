import 'package:flutter/material.dart';

class RowContainer extends StatelessWidget {
  const RowContainer(
      {required this.icon, required this.text, this.trailing, super.key});

  final Widget icon;
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
