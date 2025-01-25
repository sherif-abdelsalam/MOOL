

class Review {
  Review({
    required this.id,
    required this.productId,  
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    this.userImage,
  });

  final String id;
  final String productId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
  final String? userImage;
}
