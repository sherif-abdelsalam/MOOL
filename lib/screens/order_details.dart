import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mool/models/order.dart';
import 'package:mool/models/payment.dart';
import 'package:mool/models/product.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/status_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.order,
    required this.address,
    required this.payment,
    required this.orderProds,
  });

  final OrderItems order;
  final ShippingAddress address;
  final PaymentModel payment;
  final List<Product> orderProds;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double itemsPrice = 0;
    double discount = 0;
    for (final o in orderProds) {
      itemsPrice += o.price;
      if (o.discount != null) {
        discount += o.discount!;
      }
    }

    return CustomScaffoldHeader(
      title: "Order ${order.id}",
      bodyContent: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 16),
                _orderDetails(),
                SizedBox(height: 16),
                _shippingDetails(orderProds, screenSize),
                SizedBox(height: 16),
                _payment(),
                SizedBox(height: 16),
                _shippingAddress(),
                SizedBox(height: 16),
                _orderSummary(itemsPrice, discount),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Order ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: order.id.toString(),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xff181818),
              ),
              'Placed On ${DateFormat('MMM dd, yyyy').format(order.placedDate)}'),
          SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Order Total ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: '${order.subTotal.toString()} SAR',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shippingDetails(List<Product> products, Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipment details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          OrderStatusBar(status: order.status),
          SizedBox(height: 16),
          Text(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Color(0xff181818),
            ),
            "Delivery Estimate",
          ),
          SizedBox(height: 8),
          Text(
            '${DateFormat('EEEE, d MMMM yyyy').format(order.placedDate.add(Duration(days: 3)))}  before 9pm',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          for (final prod in products)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    prod.imageUrl,
                    width: size.width * .25,
                  ),
                  SizedBox(width: 4),
                  SizedBox(
                    width: size.width * .3,
                    child: Column(
                      children: [
                        Text(
                          prod.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sold by ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff616161),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: prod.brand,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff292D32),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${prod.price.toInt().toString()} SAR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _shippingAddress() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipping Address",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '${address.buildingNameOrNumber} ${address.streetName} , ${address.cityOrArea} , ${address.country}',
          ),
        ],
      ),
    );
  }

  Widget _payment() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '${payment.methodType[0].toUpperCase()}${payment.methodType.substring(1, payment.methodType.length)} Card Ending in **** ${payment.cardNumber.substring(12, 16)}',
          ),
        ],
      ),
    );
  }

  Widget _orderSummary(double itemsPrice, double discount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summery",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _checkoutRow("Items price", itemsPrice, Color(0xff616161)),
          SizedBox(height: 8),
          _checkoutRow(
              "Discount", -(discount / 100 * itemsPrice), Color(0xff616161)),
          SizedBox(height: 8),
          _checkoutRow("SubTotal", itemsPrice - (discount / 100 * itemsPrice),
              Color(0xff616161)),
          SizedBox(height: 8),
          SizedBox(height: 8),
          _checkoutRow("VAT Tax", 0.02 * itemsPrice, Color(0xff616161)),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 1,
            color: const Color.fromARGB(255, 235, 235, 235),
          ),
          SizedBox(height: 8),
          _checkoutRow(
            "Total",
            itemsPrice - (discount / 100 * itemsPrice) + 0.02 * itemsPrice,
            Colors.black,
            isBold: true,
          ),
        ],
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
