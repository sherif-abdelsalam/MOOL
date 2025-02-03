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
    required this.date,
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
  final DateTime date;

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      productCode: map['productCode'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price:
          (map['price'] as num?)?.toDouble() ?? 0.0, // Handle Firestore double
      brand: map['brand'] ?? '',
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: (map['colors'] as List<dynamic>?)
              ?.map((color) =>
                  Color(int.parse(color))) 
              .toList() ??
          [],
      description: map['description'] ?? '',
      fabric: map['fabric'] ?? '',
      model: map['model'] ?? '',
      shape: map['shape'] ?? '',
      tiered: map['tiered'] ?? '',
      categories: List<String>.from(map['categories'] ?? []),
      discount: (map['discount'] as num?)?.toDouble(),
      isNew: map['isNew'] as bool?,
      isBestSeller: map['isBestSeller'] as bool?,
      date: DateTime.tryParse(map['date'] ?? '') ??
          DateTime.now(), 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productCode': productCode,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'brand': brand,
      'sizes': sizes,
      'colors': colors.map((color) => color.value.toString()).toList(),
      'description': description,
      'fabric': fabric,
      'model': model,
      'shape': shape,
      'tiered': tiered,
      'categories': categories,
      'discount': discount,
      'isNew': isNew,
      'isBestSeller': isBestSeller,
      'date': date.toIso8601String(), // Store DateTime as ISO string
    };
  }
}
