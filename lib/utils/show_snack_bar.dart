import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, bool isAdded) {
  var message = "Product is no longer exist in favorites 😔";
  if (isAdded) message = "Product added to favorites 🤩";
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      content: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}
