import 'package:flutter/material.dart';

void showSnackBar(
    BuildContext context, bool isAdded, String addMessage, String removeMessage) {
  var message = removeMessage;
  if (isAdded) message = addMessage;

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 61, 61, 61),
      duration: Duration(seconds: 2),
      
      content: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}
