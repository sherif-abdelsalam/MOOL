import 'package:flutter/material.dart';
import 'package:mool/models/review.dart';
import 'package:mool/widgets/product_details/reviews.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen(
      {super.key, required this.revs, required this.ratingLines});
  final List<Review> revs;
  final Widget ratingLines;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "Rating and reviews",
      bodyContent: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 8,
              color: Color(0xffE9E8E8),
            ),
            ratingLines,
            Reviews(revs: revs),
          ],
        ),
      ),
    );
  }
}
