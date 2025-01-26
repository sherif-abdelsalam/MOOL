import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/data/dummy_products.dart';
import 'package:mool/models/product.dart';
import 'package:mool/providers/sort_provider.dart';

final sortedNewArrivalsProvider = Provider<List<Product>>((ref) {
  final sortOption = ref.watch(sortProvider);
  final newArrivals =
      dummyProducts.where((prod) => prod.isNew == true).toList();
  final sortedProducts = List<Product>.from(newArrivals);
  
  switch (sortOption) {
    case SortOption.priceHighToLow:
      sortedProducts.sort((a, b) => b.price.compareTo(a.price));
      break;
    case SortOption.priceLowToHigh:
      sortedProducts.sort((a, b) => a.price.compareTo(b.price));
      break;
    case SortOption.ratingHighToLow:
      // sortedProducts.sort((a, b) => b.rating.compareTo(a.rating));
      break;
    case SortOption.newArrival:
      sortedProducts.sort((a, b) => b.date.compareTo(a.date));
      break;
    case SortOption.none:
      break;
  }

  return sortedProducts;
});
