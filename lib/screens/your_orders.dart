import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mool/models/order.dart';
import 'package:mool/models/payment.dart';
import 'package:mool/models/product.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/providers/order_provider.dart';
import 'package:mool/providers/transaction_review_provider.dart';
import 'package:mool/screens/order_details.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/status_bar.dart';

class YourOrdersScreen extends ConsumerWidget {
  const YourOrdersScreen({super.key, required this.products});
  final List<Product> products;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderStream = ref.watch(orderProvider);

    // final orders = ref.watch(checkoutProductsProvider);

    final transData = ref.watch(transactionReviewProvider);
    final addresses = transData['addresses'] as List<ShippingAddress>;
    final payments = transData['payments'] as List<PaymentModel>;

    return CustomScaffoldHeader(
      title: "Your Orders",
      bodyContent: orderStream.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(child: Text("You did not place any order yet!"));
          }
          return Column(
            children: [
              for (final order in data)
                _buildOrderCard(
                    order, addresses[0], payments[0], products, context),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

Widget _buildOrderCard(OrderItems order, ShippingAddress address,
    PaymentModel payment, List<Product> products, BuildContext context) {
  final size = MediaQuery.of(context).size;
  List<Product> orderProds = products.where((product) {
    return order.orderProducts
        .any((orderProduct) => orderProduct.prodId == product.id);
  }).toList();

  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => OrderDetailsScreen(
            order: order,
            orderProds: orderProds,
            address: address,
            payment: payment,
          ),
        ),
      );
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
                    SizedBox(
                      width: size.width * .33,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        order.id,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
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
                    'Placed On ${DateFormat('MMM dd, yyyy').format(order.placedDate)}'),
                SizedBox(height: 16),
                Container(
                  color: const Color(0xffE9E8E8),
                  width: size.width * .5,
                  height: 1,
                ),
                SizedBox(height: 16),
                for (final p in orderProds)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * .6,
                        child: Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          '${p.title}  ${p.description}',
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
