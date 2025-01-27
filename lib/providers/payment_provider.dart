import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/payment.dart';

class PaymentProvider extends StateNotifier<List<PaymentModel>> {
  PaymentProvider() : super([]);

  void addPaymentMethod(PaymentModel payment) {
    bool isExisted = state.contains(payment);
    if (isExisted) {
      return;
    } else {
      state = [...state, payment];
    }
  }

  void removePaymentMethod(PaymentModel payment) {
    state = state.where((item) => item != payment).toList();
  }
}

final paymentProvider =
    StateNotifierProvider<PaymentProvider, List<PaymentModel>>((ref) {
  return PaymentProvider();
});
