import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/data/dummy_reviews.dart';
import 'package:mool/models/review.dart';
import 'package:mool/providers/reviews_provider.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class WriteReviewScreen extends ConsumerStatefulWidget {
  const WriteReviewScreen(
      {super.key, required this.revsLen, required this.prodId});
  final int revsLen;
  final String prodId;
  @override
  createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends ConsumerState<WriteReviewScreen> {
  int _selectedRating = 0;

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _saveReview() {
    Review newRev = Review(
      id: (widget.revsLen + 1).toString(),
      productId: widget.prodId,
      userName: "Sherif Mohamed",
      rating: _selectedRating.toDouble(),
      comment: _commentController.text,
      date: DateTime.now(),
    );

    ref.read(reviewsProvider.notifier).addReview(newRev);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "Write Review",
      bodyContent: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 8,
              color: Color(0xffE9E8E8),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 24),
                  _rateProduct(),
                  SizedBox(height: 12),
                  Text(
                    "Rate Product",
                    style: TextStyle(
                      color: Color(0xff33CCCC),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 32, bottom: 12, left: 16),
                child: Text(
                  "Write a review",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            _comment(),
            ElevatedButton(
              onPressed: _saveReview,
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _comment() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _commentController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Type your review here',
            hintStyle: TextStyle(color: Color(0xff9B9B9B), fontSize: 14),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff33CCCC)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rateProduct() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          padding: const EdgeInsets.all(0), // Adjust padding as needed
          icon: index < _selectedRating
              ? Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 40,
                )
              : Icon(
                  Icons.star_outline,
                  color: Colors.blueGrey,
                  size: 40,
                ),
          onPressed: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
        );
      }),
    );
  }
}
