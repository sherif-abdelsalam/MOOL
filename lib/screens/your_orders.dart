import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mool/models/checkout_products.dart';
import 'package:mool/models/payment.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/providers/checkout_provider.dart';
import 'package:mool/providers/payment_provider.dart';
import 'package:mool/providers/shipping_addresses.dart';
import 'package:mool/screens/order_details.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/status_bar.dart';

class YourOrdersScreen extends ConsumerWidget {
  const YourOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(checkoutProductsProvider);
    final addresses = ref.watch(addressesProvider);
    final payments = ref.watch(paymentProvider);
    Widget mainContent = Center(
      child: Text("You did not place any order yet!"),
    );

    if (orders.isNotEmpty) {
      mainContent = Column(
        children: [
          for (final order in orders)
            _buildOrderCard(order, addresses[0], payments[0], context),
        ],
      );
    }

    return CustomScaffoldHeader(
      title: "Your Orders",
      bodyContent: mainContent,
    );
  }
}

Widget _buildOrderCard(CheckoutProducts order, ShippingAddress address,
    PaymentModel payment, BuildContext context) {
  final size = MediaQuery.of(context).size;
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => OrderDetailsScreen(
                order: order,
                address: address,
                payment: payment,
              )));
    },
    child: Column(
      children: [
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "order",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Text(
                      order.id.substring(order.id.length - 8, order.id.length),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${order.subTotal.toString()} SAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff181818),
                    ),
                    'Placed On ${DateFormat('MMM dd, yyyy').format(order.placedDate!)}'),
                SizedBox(height: 16),
                Container(
                  color: const Color(0xffE9E8E8),
                  width: size.width * .5,
                  height: 1,
                ),
                SizedBox(height: 16),
                for (final p in order.checkoutProducts)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * .6,
                        child: Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          '${p.product.title}  ${p.product.description}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                  SizedBox(height: 16),
                OrderStatusBar(status: order.status),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
