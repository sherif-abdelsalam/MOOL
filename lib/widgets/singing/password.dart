import 'package:flutter/material.dart';
import 'package:mool/widgets/singing/input_filed_deocration.dart';

class Password extends StatelessWidget {
  const Password(
      {super.key, required this.labelText, required this.onSaveInput});
  final String labelText;
  final void Function(String input) onSaveInput;

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Password is valid
  }

  @override
  Widget build(BuildContext context) {
    return InputFiledDecoration(
      isPassword: true,
      labelText: labelText,
      onSaveInput: onSaveInput,
      validator: _validator,
    );
  }
}
