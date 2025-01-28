import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/models/payment.dart';
import 'package:mool/providers/payment_provider.dart';
import 'package:mool/screens/checkout.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/utils/show_snack_bar.dart';

class PaymentMethods extends ConsumerStatefulWidget {
  const PaymentMethods({super.key});

  @override
  ConsumerState<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends ConsumerState<PaymentMethods> {
  String? selectedMethod;
  bool passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController securityCodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    expirationDateController.dispose();
    securityCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onSave() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        final payments = ref.watch(paymentProvider);

        PaymentModel payment = PaymentModel(
          id: (payments.length + 1).toString(),
          cardNumber: cardNumberController.text,
          fullName: nameController.text,
          expiryDate: expirationDateController.text,
          cvv: securityCodeController.text,
          methodType: "credit",
        );
        var checkIsExisted = payments
            .where((item) => item.cardNumber.trim() != cardNumberController.text.trim())
            .toList();

        if (checkIsExisted.isNotEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 61, 61, 61),
              duration: Duration(seconds: 2),
              content: Center(
                child: Text(
                  "This card is Already Existed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        } else {
          ref.watch(paymentProvider.notifier).addPaymentMethod(payment);
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => CheckoutScreen(currentStep: 3),
          ),
        );
      }
    }

    return Column(
      children: [
        Padding(
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
                    SvgPicture.asset(
                      "images/visa.svg",
                      height: 36,
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      "images/master_card.svg",
                      height: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildPaymentOption(
                'Paymob',
                'paymob',
                SvgPicture.asset("images/pay_mob.png"),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
        Button(
          btnText: "Confirm and continue",
          onTapBtn: onSave,
        ),
      ],
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
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name on card",
              style: TextStyle(color: Color(0xff616161), fontSize: 14),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12.0,
                ),
                focusedBorder: _focusedBorder(),
                enabledBorder: _enabledBorder(),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _focusedErrorBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().isEmpty) {
                  return 'Please enter the name on the card';
                }
                if (value.trim().length < 3) {
                  return 'Name must be at least 3 chars';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Text(
              "Card Number",
              style: TextStyle(color: Color(0xff616161), fontSize: 14),
            ),
            SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              obscureText: passwordVisible,
              controller: cardNumberController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12.0,
                ),
                focusedBorder: _focusedBorder(),
                enabledBorder: _enabledBorder(),
                errorBorder: _errorBorder(),
                focusedErrorBorder: _focusedErrorBorder(),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().isEmpty) {
                  return 'Please enter the card number';
                }
                if (value.trim().length < 16 || value.trim().length > 16) {
                  return "Card number must be 16 digit number";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expiration date",
                        style:
                            TextStyle(color: Color(0xff616161), fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: expirationDateController,
                        decoration: InputDecoration(
                          hintText: 'MM/YY',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12.0,
                          ),
                          focusedBorder: _focusedBorder(),
                          enabledBorder: _enabledBorder(),
                          errorBorder: _errorBorder(),
                          focusedErrorBorder: _focusedErrorBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the expiration date';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Security code",
                        style:
                            TextStyle(color: Color(0xff616161), fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: securityCodeController,
                        decoration: InputDecoration(
                          hintText: 'CVV',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12.0,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: _focusedBorder(),
                          enabledBorder: _enabledBorder(),
                          errorBorder: _errorBorder(),
                          focusedErrorBorder: _focusedErrorBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the security code';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0xff33CCCC), width: 2.0), // Border color when focused
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: Color(0XFFCCCCCC), width: 1.5), // Border color when enabled
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.red, width: 1.5), // Border color when there's an error
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  OutlineInputBorder _focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.red,
          width: 2.0), // Border color when focused and there's an error
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}
