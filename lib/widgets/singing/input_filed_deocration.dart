import 'package:flutter/material.dart';

class InputFiledDecoration extends StatefulWidget {
  const InputFiledDecoration({
    super.key,
    required this.labelText,
    required this.onSaveInput,
    required this.validator,
    required this.isPassword,
    this.initialValue,
  });

  final String labelText;
  final void Function(String input) onSaveInput;
  final String? Function(String? value) validator;
  final bool isPassword;
  final String? initialValue;

  @override
  State<InputFiledDecoration> createState() => _InputFiledDecorationState();
}

class _InputFiledDecorationState extends State<InputFiledDecoration> {
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 14),
      initialValue: widget.initialValue ?? "",
      keyboardType: widget.labelText == "Phone Number"
          ? TextInputType.number
          : TextInputType.text,
      obscureText: widget.isPassword ? passwordVisible : false,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              )
            : null,
        labelText: widget.labelText,
        labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
      validator: widget.validator,
      onSaved: (newValue) {
        widget.onSaveInput(newValue!);
      },
    );
  }
}
