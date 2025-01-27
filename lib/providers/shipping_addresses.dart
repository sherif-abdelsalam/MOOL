import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/shipping_address.dart';

class ShippingAddressesNotifier extends StateNotifier<List<ShippingAddress>> {
  ShippingAddressesNotifier() : super([]);

  void addAddress(ShippingAddress sh) {
    state = [...state, sh];
  }
}

final addressesProvider =
    StateNotifierProvider<ShippingAddressesNotifier, List<ShippingAddress>>(
        (ref) {
  return ShippingAddressesNotifier();
});
