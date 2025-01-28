// lib/widgets/order_status_widget.dart

import 'package:flutter/material.dart';
import 'package:mool/models/checkout_products.dart';

class OrderStatusBar extends StatelessWidget {
  const OrderStatusBar({super.key, required this.status});
  final Status status;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var green = 1;
    if (status == Status.done) green = 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < 4; i++)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: i < green ? Color(0xff0DCF09) : Color(0xffB3B3B3),
                ),
                width: size.width * .19,
                height: 3,
              )
          ],
        ),
        SizedBox(height: 16),
        Text(
          status == Status.done ? "Shipped" : "Pending",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
