import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/models/review.dart';
import 'package:mool/widgets/product_details/date_formatter.dart';
import 'package:mool/widgets/product_details/review_stars.dart';
import 'package:mool/widgets/product_details/subtitles_style.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    required this.revs,
  });

  final List<Review> revs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 2,
            color: Color(0xffE9E8E8),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubtitlesStyle(title: "Reviews"),
                SizedBox(height: 16),
                _reviewContent(),
              ],
            ),
          ),
          Container(
            height: 2,
            color: Color(0xffE9E8E8),
          ),
        ],
      ),
    );
  }

  Widget _reviewContent() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Color(0xffE9E8E8),
        thickness: 1,
        height: 20,
      ),
      shrinkWrap: true,
      itemCount: revs.length,
      itemBuilder: (context, index) {
        final rev = revs[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffE9E8E8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    "images/user.svg",
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rev.userName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4E4E4E),
                      ),
                    ),
                    ReviewStars(rate: rev.rating, iconSize: 16)
                  ],
                ),
                Spacer(),
                DateFormatter(date: rev.date),
              ],
            ),
            SizedBox(height: 8),
            Text(
              rev.comment,
              style: TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
