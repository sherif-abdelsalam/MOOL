import 'package:flutter/material.dart';
import 'package:mool/models/payment.dart';

class BuildPaymentCard extends StatelessWidget {
  const BuildPaymentCard({super.key, required this.payment});
  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: Color(
                  0xffCCCCCC,
                ),
                width: 1.5)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xff33CCCC),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildPaymentsRow(payment.cardNumber, payment.expiryDate),
          ],
        ),
      ),
    );
  }
}

Widget _buildPaymentsRow(String cardNumber, String exDate) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '**** ${cardNumber.substring(11, cardNumber.length)}',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      Text(
        exDate,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
