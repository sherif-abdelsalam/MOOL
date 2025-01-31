import 'package:flutter/material.dart';
import 'package:mool/widgets/singing/input_filed_deocration.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.labelText,
    required this.onSaveInput,
    this.initialValue,
  });
  final String labelText;
  final void Function(String input) onSaveInput;
  final String? initialValue;

  String? _validator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Email is required.';
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final emailRegex = RegExp(pattern);
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputFiledDecoration(
      initialValue: initialValue,
      isPassword: false,
      labelText: labelText,
      onSaveInput: onSaveInput,
      validator: _validator,
    );
  }
}
