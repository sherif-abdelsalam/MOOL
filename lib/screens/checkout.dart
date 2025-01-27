import 'package:flutter/material.dart';
import 'package:mool/screens/Payment.dart';
import 'package:mool/widgets/checkout/shipping.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.currentStep});
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Shipping();
    if (currentStep == 2) mainContent = Payment();
    Widget headerBar = Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStep(1, "Shipping"),
            _buildStep(2, "Payment"),
            _buildStep(3, "Review"),
          ],
        ),
      ),
    );
    return CustomScaffoldHeader(
      title: "Checkout",
      bodyContent: Center(
        child: Column(
          children: [
            headerBar,
            mainContent,
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int stepNumber, String title) {
    bool isActive = stepNumber == currentStep;
    bool isCompleted = stepNumber < currentStep;

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive
                ? Color(0xff292D32)
                : isCompleted
                    ? Color(0xff33CCCC)
                    : Color(0xffB3B3B3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check_rounded, size: 16,color: Colors.white,)
                : Text(
                    stepNumber.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
          ),
        ),
        SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            color:
                isActive || isCompleted ? Color(0xff292D32) : Color(0xffB3B3B3),
            fontWeight: isCompleted ? FontWeight.bold : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
