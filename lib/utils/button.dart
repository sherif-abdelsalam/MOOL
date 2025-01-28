import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key, required this.btnText, required this.onTapBtn, this.padding});

  final String btnText;
  final void Function() onTapBtn;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: padding != null ? padding! : 16, vertical: 16),
      width: double.infinity,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: onTapBtn,
        style: ElevatedButton.styleFrom(
          elevation: 16,
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          btnText,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
