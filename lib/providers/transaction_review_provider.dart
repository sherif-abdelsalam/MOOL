import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/payment.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/providers/addresses_provider.dart';
import 'package:mool/providers/payments_provider.dart';

final transactionReviewProvider = Provider<Map<String, dynamic>>((ref) {
  final List<PaymentModel> payments = ref.watch(paymentsProvider).maybeWhen(
        data: (data) => data,
        orElse: () => [],
      );

  final List<ShippingAddress> addresses =
      ref.watch(addressesProvider).maybeWhen(
            data: (data) => data,
            orElse: () => [],
          );

  return {
    'payments': payments,
    'addresses': addresses,
  };
});
