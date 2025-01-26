import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/product.dart';

class FavoriteProductNotifier extends StateNotifier<List<Product>> {
  FavoriteProductNotifier() : super([]);

  bool toggleMealNotifier(Product prod) {
    final isProductExisted = state.contains(prod);

    if (isProductExisted) {
      state = state.where((item) => item.id != prod.id).toList();
      return false;
    } else {
      state = [...state, prod];
      return true;
    }
  }
}

final favoriteProductProvider =
    StateNotifierProvider<FavoriteProductNotifier, List<Product>>((ref) {
  return FavoriteProductNotifier();
});
