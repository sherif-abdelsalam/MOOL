import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatter extends StatelessWidget {
  const DateFormatter({super.key, required this.date});

  final DateTime date;
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat("d'${_getDaySuffix(date.day)}' MMMM yyyy").format(date);

    return Text(
      formattedDate,
      style: TextStyle(fontSize: 12, color: Color(0xff616161)),
    );
  }
}
