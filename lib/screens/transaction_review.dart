import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/providers/cart_product_provider.dart';
import 'package:mool/providers/checkout_provider.dart';
import 'package:mool/providers/payment_provider.dart';
import 'package:mool/providers/shipping_addresses.dart';
import 'package:mool/screens/checkout.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/checkout/build_payment_card.dart';
import 'package:mool/widgets/checkout/build_shipping_card.dart';

class TransactionReview extends ConsumerWidget {
  const TransactionReview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final payments = ref.watch(paymentProvider);
    final shipAddress = ref.watch(addressesProvider);
    final checkout = ref.watch(checkoutProductsProvider);

    void submitOrder() {
      ref
          .watch(checkoutProductsProvider.notifier)
          .approveCheckout(checkout[0].id, DateTime.now());

      ref.watch(cartProductsProvider.notifier).restCart();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CheckoutScreen(
            currentStep: 4,
            stepsBarColor: Color(0xffF7F7F7),
          ),
        ),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Please confirm you order",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  for (final p in payments) BuildPaymentCard(payment: p),
                  for (final sh in shipAddress)
                    BuildShippingCard(
                      sh: sh,
                      isTransRev: true,
                    ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(size.width * .04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        _checkoutRow(
                          "Subtotal",
                          checkout[0].subTotal,
                          Color(0xff616161),
                        ),
                        SizedBox(height: 8),
                        _checkoutRow(
                          "Shipping Fee",
                          checkout[0].subTotal * 0.02,
                          Color(0xff616161),
                        ),
                        SizedBox(height: 16),
                        _checkoutRow(
                          "Total",
                          checkout[0].subTotal + checkout[0].subTotal * 0.02,
                          Colors.black,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  Button(
                    btnText: "Submit Order",
                    onTapBtn: submitOrder,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkoutRow(String label, double value, Color color,
      {bool isBold = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Spacer(),
        Text(
          '$value SAR',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
