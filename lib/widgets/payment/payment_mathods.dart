import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPaymentOption(
            'Cash on Delivery',
            'cash',
            null,
          ),
          const SizedBox(height: 12),
          _buildPaymentOption(
            'Credit Card',
            'credit',
            Row(
              children: [
                SvgPicture.asset("images/visa.svg"),
                const SizedBox(width: 8),
                SvgPicture.asset("images/master_card.svg"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildPaymentOption(
            'Paymob',
            'paymob',
            SvgPicture.asset("images/pay_mob.svg"),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, String value, Widget? trailing) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: selectedMethod == value
            ? Border.all(color: Color(0xff33CCCC), width: 2)
            : null,
      ),
      child: Column(
        children: [
          RadioListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
            value: value,
            groupValue: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value.toString();
              });
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            activeColor: Colors.black,
            selected: selectedMethod == value,
          ),
          if (selectedMethod == 'credit' && value == 'credit')
            _buildCreditCardForm(),
        ],
      ),
    );
  }

  Widget _buildCreditCardForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Name on card',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: 'Card Number',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Expiration date',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Security code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
