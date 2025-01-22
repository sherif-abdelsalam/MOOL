import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("images/truck-fast.svg"),
          SizedBox(width: 8),   
          Text(
            "48 HOURS DELIVERY",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
              fontFamily: 'Roboto'
            ),
          ),
        ],
      ),
    );
  }
}
