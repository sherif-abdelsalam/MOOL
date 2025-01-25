import 'package:flutter/material.dart';
import 'package:mool/widgets/product_details/review_stars.dart';
import 'package:mool/widgets/product_details/subtitles_style.dart';

class RatingLines extends StatelessWidget {
  const RatingLines({
    super.key,
    required this.avgRatings,
    required this.frequencyRatings,
    required this.reviewsLength,
  });
  final double avgRatings;
  final int reviewsLength;
  final Map<int, int> frequencyRatings;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubtitlesStyle(title: "Ratings"),
            SizedBox(height: 16),
            Row(
              children: [
                Column(
                  children: [
                    ReviewStars(rate: avgRatings, iconSize: 24),
                    Text(
                      avgRatings.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 5; i >= 1; i--)
                      ratingBar(
                          label: "$i Star",
                          percentage: frequencyRatings[i] == null
                              ? 0
                              : frequencyRatings[i]! / reviewsLength.toDouble())
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingBar({required String label, required double percentage}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(width: 12),
          Container(
            height: 2,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xffB3B3B3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFC93E),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 40,
            child: Text(
              "${(percentage * 100).toInt()}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
