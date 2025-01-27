import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/data/dummy_reviews.dart';
import 'package:mool/models/review.dart';

class ReviewsProvider extends StateNotifier<List<Review>> {
  ReviewsProvider() : super(dummyReviews);
  void addReview(Review review) {
    state = [...state, review]; //
  }
}

final reviewsProvider =
    StateNotifierProvider<ReviewsProvider, List<Review>>((ref) {
  return ReviewsProvider();
});
