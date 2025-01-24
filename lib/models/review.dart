

class Review {
  Review({
    required this.id,
    required this.productId,  // Foreign key to Product
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    this.userImage,  // Optional user profile image
  });

  final String id;
  final String productId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
  final String? userImage;
}
