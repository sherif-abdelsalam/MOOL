import 'package:flutter/material.dart';
import 'package:mool/widgets/singing/input_filed_deocration.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.labelText,
    required this.onSaveInput,
    this.initialValue,
  });
  final String labelText;
  final void Function(String input) onSaveInput;
  final String? initialValue;

  String? _validator(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputFiledDecoration(
      isPassword: false,
      labelText: labelText,
      onSaveInput: onSaveInput,
      validator: _validator,
      initialValue: initialValue,
    );
  }
}
