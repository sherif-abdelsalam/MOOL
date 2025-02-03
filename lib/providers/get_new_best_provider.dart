import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/product.dart';

final productProvider = FutureProvider<Map<String, List<Product>>>((ref) async {
  Future<List<Product>> fetchProducts(String field, bool value) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('products')
        .where(field, isEqualTo: value)
        .get();

    return result.docs
        .map((doc) =>
            Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  final results = await Future.wait([
    fetchProducts('isNew', true),
    fetchProducts('isBestSeller', true),
  ]);

  return {
    'newArrivals': results[0], 
    'bestSellers': results[1]
  };
});
