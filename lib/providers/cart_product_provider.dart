import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/cart_product.dart';

class CartProductNotifier extends StateNotifier<List<CartProduct>> {
  CartProductNotifier() : super([]);

  void addCartProduct(CartProduct prod) {
    bool isExisted = state.contains(prod);
    if (isExisted) {
      return;
    } else {
      state = [...state, prod];
    }
  }

  void removeCartProduct(CartProduct prod) {
    state = state.where((item) => item != prod).toList();
  }
}

final cartProductsProvider =
    StateNotifierProvider<CartProductNotifier, List<CartProduct>>((ref) {
  return CartProductNotifier();
});
