import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/checkout_products.dart';

class CheckoutProviderNotifier extends StateNotifier<List<CheckoutProducts>> {
  CheckoutProviderNotifier() : super([]);

  void addCheckoutProducts(CheckoutProducts prod) {
    state = [...state, prod];
  }

  void approveCheckout(String checkoutId, DateTime placedDate) {
    state = state.map((checkout) {
      if (checkout.id == checkoutId) {
        return CheckoutProducts(
          checkoutProducts: checkout.checkoutProducts,
          subTotal: checkout.subTotal,
          status: Status.done,
          placedDate: placedDate,
        );
      }
      return checkout;
    }).toList();
  }
}

final checkoutProductsProvider =
    StateNotifierProvider<CheckoutProviderNotifier, List<CheckoutProducts>>(
        (ref) {
  return CheckoutProviderNotifier();
});
