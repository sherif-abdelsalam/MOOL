  import 'package:flutter/material.dart';
import 'package:mool/data/dummy_products.dart';
import 'package:mool/models/category.dart';
import 'package:mool/models/product.dart';
import 'package:mool/widgets/home/products.dart';

void selectCategory(BuildContext context, Category category) {
    final List<Product> categoryProducts = dummyProducts
        .where((prod) => prod.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Products(
          title: category.name,
          prods: categoryProducts,
        ),
      ),
    );
  }
