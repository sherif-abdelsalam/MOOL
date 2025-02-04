import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/checkout_products.dart';
import 'package:mool/models/order.dart';
import 'package:mool/models/payment.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/providers/cart_product_provider.dart';
import 'package:mool/providers/checkout_provider.dart';
import 'package:mool/providers/transaction_review_provider.dart';
import 'package:mool/screens/checkout.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/checkout/build_payment_card.dart';
import 'package:mool/widgets/checkout/build_shipping_card.dart';

class TransactionReview extends ConsumerWidget {
  const TransactionReview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final transactionData = ref.watch(transactionReviewProvider);
    final payments = transactionData['payments'] as List<PaymentModel>;
    final shipAddress = transactionData['addresses'] as List<ShippingAddress>;

    List<CheckoutProducts> checkout = ref.watch(checkoutProductsProvider);

    List<OrderProduct> orderProducts = checkout.last.checkoutProducts.map((e) {
      return OrderProduct(
        prodId: e.product.id,
        color: e.color,
        size: e.size,
      );
    }).toList();

    void submitOrder() {
      ref.watch(checkoutProductsProvider.notifier).approveCheckout(
            checkout[checkout.length - 1].id,
            DateTime.now(),
          );
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final order = OrderItems(
          orderProducts: orderProducts,
          placedDate: DateTime.now(),
          status: Status.done,
          subTotal: checkout[checkout.length - 1].subTotal,
          userId: userId);
      ref.watch(cartProductsProvider.notifier).restCart();
      CollectionReference orders =
          FirebaseFirestore.instance.collection('orders');
      try {
        orders.add(order.toMap());
      } catch (e) {
        print(">>>>>>>>>>>>>>>>>>>>$e");
      }

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
                BuildPaymentCard(payment: payments[payments.length - 1]),
                BuildShippingCard(
                  sh: shipAddress[shipAddress.length - 1],
                  isTransRev: true,
                ),
              ],
            ),
            SizedBox(
              height: 32,
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
