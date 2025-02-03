import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mool/models/category.dart';
import 'package:mool/models/product.dart';
import 'package:mool/widgets/home/products.dart';

void selectCategory(BuildContext context, Category category) async {
  final QuerySnapshot result =
      await FirebaseFirestore.instance.collection('products').get();

  final allProducts = result.docs
      .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
      .toList();

  final List<Product> categoryProducts = allProducts
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
