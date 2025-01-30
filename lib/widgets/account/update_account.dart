import 'package:flutter/material.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/singing/email_input.dart';
import 'package:mool/widgets/singing/text_input.dart';

class UpdateAccount extends StatelessWidget {
  const UpdateAccount({
    super.key,
    required this.formKey,
    required this.onSaveName,
    required this.onSaveEmail,
    required this.onSavePhone,
    required this.onUpdateProfile,
    required this.enteredEmail,
    required this.enteredName,
    required this.enteredPhoneNumber,
  });

  final GlobalKey<FormState> formKey;
  final void Function(String val) onSaveName;
  final void Function(String val) onSaveEmail;
  final void Function(String val) onSavePhone;
  final void Function() onUpdateProfile;

  final String enteredName;
  final String enteredEmail;
  final String enteredPhoneNumber;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 14, color: Color(0xff616161));

    return CustomScaffoldHeader(
      title: "Your account",
      bodyContent: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  Name",
                  style: style,
                ),
                SizedBox(height: 8),
                TextInput(labelText: "", onSaveInput: onSaveName, initialValue: enteredName,),
                SizedBox(height: 16),
                Text(
                  "  Email",
                  style: style,
                ),
                SizedBox(height: 8),
                EmailInput(labelText: "", onSaveInput: onSaveEmail, initialValue: enteredEmail,),
                SizedBox(height: 16),
                Text(
                  "  Phone",
                  style: style,
                ),
                SizedBox(height: 8),
                TextInput(labelText: "", onSaveInput: onSavePhone),
                SizedBox(height: 48),
                Button(
                  btnText: "Update profile",
                  onTapBtn: onUpdateProfile,
                  hasNotOutsideColor: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
