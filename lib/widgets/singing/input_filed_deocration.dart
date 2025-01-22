import 'package:flutter/material.dart';

class InputFiledDecoration extends StatelessWidget {
  const InputFiledDecoration({
    super.key,
    required this.labelText,
    required this.onSaveInput,
    required this.validator,
    required this.isPassword,
  });

  final String labelText;
  final void Function(String input) onSaveInput;
  final String? Function(String? value) validator;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 14),
      keyboardType: labelText == "Email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
            vertical: 8, horizontal: 12),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
      ),
      obscureText: isPassword ? true : false,
      validator: validator,
      onSaved: (newValue) {
        onSaveInput(newValue!);
      },
    );
  }
}
