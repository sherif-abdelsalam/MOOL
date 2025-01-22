import 'package:flutter/material.dart';
import 'package:mool/icons/arrow_back_icon.dart';

class ForgetResetHeader extends StatelessWidget {
  const ForgetResetHeader({super.key, required this.header});
  final String header;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 160,
          color: const Color(0xFF292D32),
        ),
        Positioned(
          left: 8,
          child: ArrowBackIcon(),
        ),
        Positioned(
          left: 20,
          top: 54,
          child: Text(
            header,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
