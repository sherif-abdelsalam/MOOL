import 'package:flutter/material.dart';

class ReviewStars extends StatelessWidget {
  const ReviewStars({super.key, required this.rate, required this.iconSize});

  final double rate;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star_purple500_sharp,
          color: index < rate.round().toInt()
              ? Color(0xffFFC93E)
              : Color(0xffCCCCCC),
          size: iconSize,
        );
      }),
    );
  }
}
