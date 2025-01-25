import 'package:flutter/material.dart';

class SeeAllReviews extends StatelessWidget {
  const SeeAllReviews({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Text(
                  "See all reviews",
                  style: TextStyle(fontSize: 14, color: Color(0xff616161)),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xff616161),
                  size: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
