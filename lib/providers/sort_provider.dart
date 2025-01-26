import 'package:flutter_riverpod/flutter_riverpod.dart';
enum SortOption {
  priceHighToLow,
  priceLowToHigh,
  newArrival,
  ratingHighToLow,
  none,
}

class SortProviderNotifier extends StateNotifier<SortOption> {
  SortProviderNotifier() : super(SortOption.none);
  void setSort(SortOption option) {
    state = state == option ? SortOption.none : option;
  }
}

final sortProvider =
    StateNotifierProvider<SortProviderNotifier, SortOption>((ref) {
  return SortProviderNotifier();
});
