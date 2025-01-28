import 'package:flutter/material.dart';
import 'package:mool/models/product.dart';

class CartProduct {
  CartProduct({
    required this.id,
    required this.product,
    required this.color,
    required this.size,
  });
  final String id;
  final Product product;
  final Color color;
  final String size;
}
