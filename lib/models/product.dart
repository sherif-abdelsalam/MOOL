class Product {
  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.categories,
    this.discount,
  });

  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final double? discount;
  final List<String> categories;
}
