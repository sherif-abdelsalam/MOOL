import 'package:flutter/material.dart';

class Product {
  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.brand,
    required this.sizes,
    required this.colors,
    required this.description,
    required this.fabric,
    required this.model,
    required this.shape,
    required this.tiered,
    this.discount,
    this.categories = const [],
    this.isBestSeller,
    this.isNew,
    required this.productCode,
  });

  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String brand;
  final List<String> sizes;
  final List<Color> colors;
  final String description;
  final String fabric;
  final String model;
  final String shape;
  final String tiered;
  final double? discount;
  final List<String> categories;
  final bool? isNew;
  final bool? isBestSeller;
  final String productCode;
}
